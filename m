Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jul 2009 14:47:52 +0200 (CEST)
Received: from wa-out-1112.google.com ([209.85.146.181]:21177 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1493035AbZGHMrp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 8 Jul 2009 14:47:45 +0200
Received: by wa-out-1112.google.com with SMTP id n4so940154wag.0
        for <multiple recipients>; Wed, 08 Jul 2009 05:47:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=mE8YPKcI5aEevLLsMRTN7gj/2kNftjBnhhb/6nOz8YI=;
        b=nXDPwrumP3YogLI5zIC5nTsFOTjQ8onx/3wo6LVExa/4NFfmHgQdfK0NfBAKA9QGbK
         sb/3OCgP+a2cSPSeDj/dEEraBJXsirhSkGxjfotU19NUHR8T6PpBMBknU28xehvaNZGU
         hjc9flul9Ng1FZKy/eE7GpaesPRccNcSzyAHI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=YRZZJSHf4n6b5pMs2HAqAiR70wYaO9QegYeNA4Jr9zQI0Y6HG2AlZByM+GtomhkQPa
         TIbLh9UhCIGtxs2rn9s8jWloNvJ8YX1YAaygHzBhODBNYgsSZrGHnXlhGbzl+K6xgd8M
         b3Ro7hSGrjff3gPNHkzCG1owUDXtdKhFjy52M=
MIME-Version: 1.0
Received: by 10.114.106.13 with SMTP id e13mr11541604wac.87.1247057263033; 
	Wed, 08 Jul 2009 05:47:43 -0700 (PDT)
In-Reply-To: <20090708103756.GB22308@linux-mips.org>
References: <4f9abdc70907080107t28fdac03h86b834a60806fb10@mail.gmail.com>
	 <20090708103756.GB22308@linux-mips.org>
Date:	Wed, 8 Jul 2009 18:17:42 +0530
Message-ID: <4f9abdc70907080547l501128bg7c920e206e0068c3@mail.gmail.com>
Subject: Re: Linux port failing on MIPS32 24Kc
From:	joe seb <joe.seb8@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Content-Type: multipart/mixed; boundary=00163645730a2dad0e046e31250b
Return-Path: <joe.seb8@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23678
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe.seb8@gmail.com
Precedence: bulk
X-list: linux-mips

--00163645730a2dad0e046e31250b
Content-Type: multipart/alternative; boundary=00163645730a2dad03046e312509

--00163645730a2dad03046e312509
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

We made the following changes and tried,

-> applied the patch given by you.
-> changed the PHYS_OFFSET to 0x10000000 to match our memory offset.
-> cache write back mode enabled

Still we face the same problem. It crashes at different points when it
enters the user space. I have attached one of the logs.

But in cache write through mode it works.

One comment about the patch, it tries to change the start of the valid pfn
range from ARCH_PFN_OFFSET to min_low_pfn.
But in bootmem_init() present in arch/mips/kernel/setup.c, line 324,
min_low_pfn = ARCH_PFN_OFFSET;

So appears like the previous pfn_valid check was also doing something
similar. Correct me if I am wrong.

Regards,
Joe

--00163645730a2dad03046e312509
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>We made the following changes and tried,<br><br>-&gt; applied th=
e patch given by you.<br>-&gt; changed the PHYS_OFFSET to 0x10000000 to mat=
ch our memory offset.<br>-&gt; cache write back mode enabled<br><br>Still w=
e face the same problem. It crashes at different points when it enters the =
user space. I have attached one of the logs.<br>
<br>But in cache write through mode it works.<br><br>One comment about the =
patch, it tries to change the start of the valid pfn range from ARCH_PFN_OF=
FSET to min_low_pfn.<br>But in bootmem_init() present in arch/mips/kernel/s=
etup.c, line 324, <br>
min_low_pfn =3D ARCH_PFN_OFFSET;<br><br>So appears like the previous pfn_va=
lid check was also doing something similar. Correct me if I am wrong.<br><b=
r>Regards,<br>Joe<br><br><br><br><br><br>

--00163645730a2dad03046e312509--
--00163645730a2dad0e046e31250b
Content-Type: application/octet-stream; name=log_1
Content-Disposition: attachment; filename=log_1
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fww1lqlk0

TGludXggdmVyc2lvbiAyLjYuMjkuNCAoZ2NjIHZlcnNpb24gNC4zLjIgKFNvdXJjZXJ5IEcKKysg
TGl0ZSA0LjMtNTEpICkgIzggUFJFRU1QVCBXZWQgSnVsIDggMTc6MjQ6MzEgSVNUIDIwMDkKQ1BV
IHJldmlzaW9uIGlzOiAwMTAxOTM3YyAoTUlQUyAyNEtjKQpEZXRlcm1pbmVkIHBoeXNpY2FsIFJB
TSBtYXA6ClVzZXItZGVmaW5lZCBwaHlzaWNhbCBSQU0gbWFwOgogbWVtb3J5OiAwMTAwMDAwMCBA
IDEwMDAwMDAwICh1c2FibGUpCkluaXRyZCBub3QgZm91bmQgb3IgZW1wdHkgLSBkaXNhYmxpbmcg
aW5pdHJkClpvbmUgUEZOIHJhbmdlczoKICBOb3JtYWwgICAweDAwMDEwMDAwIC0+IDB4MDAwMTEw
MDAKTW92YWJsZSB6b25lIHN0YXJ0IFBGTiBmb3IgZWFjaCBub2RlCmVhcmx5X25vZGVfbWFwWzFd
IGFjdGl2ZSBQRk4gcmFuZ2VzCiAgICAwOiAweDAwMDEwMDAwIC0+IDB4MDAwMTEwMDAKQnVpbHQg
MSB6b25lbGlzdHMgaW4gWm9uZSBvcmRlciwgbW9iaWxpdHkgZ3JvdXBpbmcgb2ZmLiAgVG90YWwg
cGFnZXM6IDQwNjQKS2VybmVsIGNvbW1hbmQgbGluZTogbWVtPTE2TUAyNTZNIGNvbnNvbGU9dHR5
UzAsOTYwMApQcmltYXJ5IGluc3RydWN0aW9uIGNhY2hlIDMya0IsIFZJUFQsIDQtd2F5LCBsaW5l
c2l6ZSAzMiBieXRlcy4KUHJpbWFyeSBkYXRhIGNhY2hlIDMya0IsIDQtd2F5LCBQSVBULCBubyBh
bGlhc2VzLCBsaW5lc2l6ZSAzMiBieXRlcwpVc2luZyBjYWNoZSBhdHRyaWJ1dGUgMwpXcml0aW5n
IEVyckN0bCByZWdpc3Rlcj0wMDAwMDAwMApSZWFkYmFjayBFcnJDdGwgcmVnaXN0ZXI9MDAwMDAw
MDAKUElEIGhhc2ggdGFibGUgZW50cmllczogNjQgKG9yZGVyOiA2LCAyNTYgYnl0ZXMpCkNQVSBm
cmVxdWVuY3kgNTAuMDAgTUh6CmNvbnNvbGUgW3R0eVMwXSBlbmFibGVkCkRlbnRyeSBjYWNoZSBo
YXNoIHRhYmxlIGVudHJpZXM6IDIwNDggKG9yZGVyOiAxLCA4MTkyIGJ5dGVzKQpJbm9kZS1jYWNo
ZSBoYXNoIHRhYmxlIGVudHJpZXM6IDEwMjQgKG9yZGVyOiAwLCA0MDk2IGJ5dGVzKQpNZW1vcnk6
IDEzNzY4ay8xNjM4NGsgYXZhaWxhYmxlICgxMjEyayBrZXJuZWwgY29kZSwgMjYxNmsgcmVzZXJ2
ZWQsIDI0MGsgZGF0YSwgNgo3NmsgaW5pdCwgMGsgaGlnaG1lbSkKQ2FsaWJyYXRpbmcgZGVsYXkg
bG9vcC4uLiAzMy4xNyBCb2dvTUlQUyAobHBqPTE2NTg4OCkKTW91bnQtY2FjaGUgaGFzaCB0YWJs
ZSBlbnRyaWVzOiA1MTIKVkZTOiBEaXNrIHF1b3RhcyBkcXVvdF82LjUuMgpEcXVvdC1jYWNoZSBo
YXNoIHRhYmxlIGVudHJpZXM6IDEwMjQgKG9yZGVyIDAsIDQwOTYgYnl0ZXMpCm1zZ21uaSBoYXMg
YmVlbiBzZXQgdG8gMjYKU2VyaWFsOiA4MjUwLzE2NTUwIGRyaXZlciwgMiBwb3J0cywgSVJRIHNo
YXJpbmcgZW5hYmxlZApzZXJpYWw4MjUwOiB0dHlTMCBhdCBNTUlPIDB4YTFhMzAwMDAgKGlycSA9
IDE4OCkgaXMgYSAxNjU1MEEKc2VyaWFsODI1MDogdHR5UzEgYXQgTU1JTyAweGExYTQwMDAwIChp
cnEgPSAxODkpIGlzIGEgMTY1NTBBCkZyZWVpbmcgdW51c2VkIGtlcm5lbCBtZW1vcnk6IDY3Nmsg
ZnJlZWQKQWxnb3JpdGhtaWNzL01JUFMgRlBVIEVtdWxhdG9yIHYxLjUKdm1hbGxvYyBmYXVsdCAK
Q1BVIDAgVW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgcGFnaW5nIHJlcXVlc3QgYXQgdmlydHVhbCBh
ZGRyZXNzIGNjY2NjY2Y0LCBlcGMgPT0KIDkwMDgxYjVjLCByYSA9PSA5MDA4YmQ1OCBmbyAtIDAK
T29wc1sjMV06CkNwdSAwCiQgMCAgIDogMDAwMDAwMDAgOTBmYWI2OGEgY2NjY2NjY2MgY2NjY2Nj
ZjAKJCA0ICAgOiA5MDIxMjQxYyA5MDIxMjU2YyBjY2NjY2NjYyA5MDIxMjQxYwokIDggICA6IDAw
MDAwMDAxIDkwMjQwMDAwIDAwNDAwMDAwIDAwMDAwMTIxCiQxMiAgIDogMDAwNDAwMDAgMDAwMDAw
MDAgOTJlOWExYTMgMzcyMzcwMmEKJDE2ICAgOiA5MGRkYjU4YyA5MDIxMjQxYyA5MDIxMGM2MCAw
MDAwMDAwMAokMjAgICA6IDkwMjEyNDkwIDkwMjEwYzYwIDAwMDAwMDAwIDkwZGU1NGEwCiQyNCAg
IDogMDAwMDAwMDAgMDAwMDAwMDAgICAgICAgICAgICAgICAgICAKJDI4ICAgOiA5MDIwNDAwMCA5
MDIwNWM0OCAwODAwMTg3NSA5MDA4YmQ1OApIaSAgICA6IDAwOTg5NjNhCkxvICAgIDogY2ViMTEx
MDAKZXBjICAgOiA5MDA4MWI1YyB2bWFfcHJpb190cmVlX2FkZCsweDIwLzB4NzQKICAgIE5vdCB0
YWludGVkCnJhICAgIDogOTAwOGJkNTggdm1hX2xpbmsrMHg4Yy8weDExYwpTdGF0dXM6IDEwMDA0
NDAzICAgIEtFUk5FTCBFWEwgSUUgCkNhdXNlIDogMDA4MDAwMDgKQmFkVkEgOiBjY2NjY2NmNApQ
cklkICA6IDAxMDE5MzdjIChNSVBTIDI0S2MpClByb2Nlc3MgcmNTIChwaWQ6IDEwLCB0aHJlYWRp
bmZvPTkwMjA0MDAwLCB0YXNrPTkwMjAyOTc4LCB0bHM9MDA1M2Y0NzApClN0YWNrIDogMDAwMDAw
MDIgMzBlMjZiMjMgMDAwMDAwMDAgOTAyMTI0MWMgOTAyMTI0ODggOTAwNjk4ZjQgOTAyMTI0ODgg
MDA0MDAwMDAKICAgICAgICA5MDIxMjQ5MCA5MDIxMjQxYyAwMDAwMDAwMSA5MDA4ZDgxOCA5MDIx
MGM5NCA5MDEwNmY1OCA5MDIxNTUyMCA5MDIxMGM2MAogICAgICAgIDkwMjEyNDg4IDAwMDAwMDAw
IDkwZGU1NGEwIDAwMDAwMDAwIDAwMDAwMDAwIDAwNDAwMDAwIDAwMDAwMTIxIDkwZGRiNGY0CiAg
ICAgICAgMDAwMDAwMDAgOTAyMTBjOTQgMDAwMDAwMDAgZmZmZmYwMDAgMDA0MDAwMDAgMDAxMjEw
MDAgOTAyMDVmMzAgOTBkZTU0YTAKICAgICAgICAwMDAwMDAwNSAwMDAwMDAwMCAwMDAwMDAwMCA5
MDBjY2U1OCA5MDIxMjQ3MCAwMDAwMDAwMCAwMDEyMTAwMCAwMDAwNjAxMgogICAgICAgIC4uLgpD
YWxsIFRyYWNlOgpbPDkwMDgxYjVjPl0gdm1hX3ByaW9fdHJlZV9hZGQrMHgyMC8weDc0Cls8OTAw
OGJkNTg+XSB2bWFfbGluaysweDhjLzB4MTFjCls8OTAwOGQ4MTg+XSBtbWFwX3JlZ2lvbisweDNh
OC8weDVjNApbPDkwMGNjZTU4Pl0gZWxmX21hcCsweDE0OC8weDFhMApbPDkwMGNkNDQ4Pl0gbG9h
ZF9lbGZfYmluYXJ5KzB4NTk4LzB4MTQxMApbPDkwMGEwNGVjPl0gc2VhcmNoX2JpbmFyeV9oYW5k
bGVyKzB4YTAvMHgyYmMKWzw5MDBjYjcxMD5dIGxvYWRfc2NyaXB0KzB4MmQwLzB4MmUwCls8OTAw
YTA0ZWM+XSBzZWFyY2hfYmluYXJ5X2hhbmRsZXIrMHhhMC8weDJiYwpbPDkwMGExYWRjPl0gZG9f
ZXhlY3ZlKzB4Mjk4LzB4MzAwCls8OTAwMGM2OWM+XSBzeXNfZXhlY3ZlKzB4NGMvMHg3OApbPDkw
MDAyMzk4Pl0gc3RhY2tfZG9uZSsweDIwLzB4M2MKCgpDb2RlOiA4Y2E2MDAzMCAgMTBjMDAwMDgg
IDI0YzMwMDI0IDw4Y2MyMDAyOD4gMjQ4NDAwMjQgIGFjZTMwMDI0ICBhY2M0MDAyOCAgYWM0NAow
MDAwICAwM2UwMDAwOCAKbm90ZTogcmNTWzEwXSBleGl0ZWQgd2l0aCBwcmVlbXB0X2NvdW50IDEK
QlVHOiBzY2hlZHVsaW5nIHdoaWxlIGF0b21pYzogcmNTLzEwLzB4MDAwMDAwMDIKQ2FsbCBUcmFj
ZToKWzw5MDAwM2ZkOD5dIGR1bXBfc3RhY2srMHg4LzB4MzgKWzw5MDAwNDhhOD5dIHNjaGVkdWxl
KzB4NTYwLzB4NzJjCls8OTAwMDc4MmM+XSBfX2Rvd25fcmVhZCsweGU4LzB4MTg4Cls8OTAwMmE5
Yjg+XSBleGl0X21tKzB4M2MvMHgyNjgKWzw5MDAyY2VjMD5dIGRvX2V4aXQrMHhmNC8weDg4Ywpb
PDkwMDBlMDVjPl0gbm1pX2V4Y2VwdGlvbl9oYW5kbGVyKzB4MC8weDM0Cgo=
--00163645730a2dad0e046e31250b--
