Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB7DKnu06689
	for linux-mips-outgoing; Fri, 7 Dec 2001 05:20:49 -0800
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB7DKeo06685
	for <linux-mips@oss.sgi.com>; Fri, 7 Dec 2001 05:20:40 -0800
Message-Id: <200112071320.fB7DKeo06685@oss.sgi.com>
Received: (qmail 9777 invoked from network); 7 Dec 2001 12:15:23 -0000
Received: from unknown (HELO foxsen) (@159.226.40.150)
  by 159.226.39.4 with SMTP; 7 Dec 2001 12:15:23 -0000
Date: Fri, 7 Dec 2001 20:18:39 +0800
From: Zhang Fuxin <fxzhang@ict.ac.cn>
To: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: [PATCH] unaligned.c
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====_Dragon404255377684_====="
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.

--=====_Dragon404255377684_=====
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit

hi,linux-mips,
 This patch does:
  1.As Mr. Atsushi Nemoto has pointed out,the newest unaligned.c leave out several jb in
the sw/sh emulation code.It will lead to oops if someone use unaligned addresses as syscall 
arguments to be stored to.Because the fixup code won't return to emulate_load_store_insn then.

  2.when search_exception_table does find a fixup in emulate_load_store_insn,I think we should
   skip compute_return_epc(regs) in do_ade then.Or it will jump to wrong fixup position later.
   ltp failed the getsockname syscall test in this way:
           getsockname(fd,&sock,(int *)1)         1 is used at the position of &sinlen.
       then,kernel will finally call get_user to fetch the user provided len and
       cause a AdeL exception: 
             get_user(len,ulen)
              (a fixup installed for the lw)
                 ---->exception
                       ---> do_ade
                         ------>emulate_load_store_insn
                                 emulate fail
                                           --->exception
                                           <---fixup
                                 search_exception_table find the handler
                                 installed by get_user and change 
                                  regs->cp0_epc to the fixup position
                          <-------return
                          compute_return_epc(regs) ADD another 4 to epc!
                 <----------------
               execution continues from fixup + 4,this omit the code to load -EFAULT to return
               value of get_user,may lead to further failures
   so i propose watch epc during emulate_load_store_insn,if it changes,then skip compute_return
   _epc
             
  3.(optional,implemented)it may be better for search_exception_table & fixup_exception
   to use PC instead of regs->cp0_epc as arguments. PC points to the actual load/store 
   instruction anyway, although this is for kernel code so it is almost impossible for 
   user space accessing code to put load/store in a branch delay.
  
  4.(optional,unimplemented) Will it be more efficient to put use emulation code of lw/lh/sw/sh
    before other impossible conditions?

  Am i missing something?

  BTW: 
   Could somebody be so kind to explain the use of save_static_function?I know they build
  a pseudo function with a return, so call sys_sigsuspend will fall through to _sys_sigsuspend
  but what's the use? Nobody calls _sys_sigsuspend.


Regards
            Zhang Fuxin
            fxzhang@ict.ac.cn

--=====_Dragon404255377684_=====
Content-Type: application/octet-stream; name="unaligned.c.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="unaligned.c.patch"

MjE5YTIyMAo+IAkJCSJqXHQzYlxuXHQiCjI1OGEyNjAKPiAJCQkialx0M2Jcblx0IgoyODVhMjg4
Cj4gCQkJImpcdDNiXG5cdCIKMzMyYzMzNQo8IAlmaXh1cCA9IHNlYXJjaF9leGNlcHRpb25fdGFi
bGUocmVncy0+Y3AwX2VwYyk7Ci0tLQo+IAlmaXh1cCA9IHNlYXJjaF9leGNlcHRpb25fdGFibGUo
cGMpOwozMzVjMzM4CjwgCQluZXdfZXBjID0gZml4dXBfZXhjZXB0aW9uKGRwZl9yZWcsIGZpeHVw
LCByZWdzLT5jcDBfZXBjKTsKLS0tCj4gCQluZXdfZXBjID0gZml4dXBfZXhjZXB0aW9uKGRwZl9y
ZWcsIGZpeHVwLCBwYyk7CjM2MWEzNjUKPiAJdW5zaWduZWQgbG9uZyBvbGRlcGM7CjM4N2EzOTIK
PiAJb2xkZXBjID0gcmVncy0+Y3AwX2VwYzsKMzkyYzM5Nyw0MDMKPCAJY29tcHV0ZV9yZXR1cm5f
ZXBjKHJlZ3MpOwotLS0KPiAJCj4gCS8qIElmIGVwYyBjaGFuZ2VkIHVuZGVyIHVzLHRoZSBvbmx5
IHBvc3NpYmlsaXR5IGlzIHRoZSBleGNlcHRpb24KPiAJICogaXMgZm9yd2FyZGVkIHRvIG5ldyBs
b2NhdGlvbiBkdXJpbmcgZml4dXAsdGhlbiB3ZSBjYW4ndCBjaGFuZ2UKPiAJICogaXQgaGVyZS0t
emZ4Cj4gCSAqLwo+IAlpZiAob2xkZXBjID09IHJlZ3MtPmNwMF9lcGMpCj4gCQljb21wdXRlX3Jl
dHVybl9lcGMocmVncyk7Cg==

--=====_Dragon404255377684_=====--
