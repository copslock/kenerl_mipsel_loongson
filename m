Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7NNBJh03644
	for linux-mips-outgoing; Thu, 23 Aug 2001 16:11:19 -0700
Received: from mail.ocs.com.au (ppp0.ocs.com.au [203.34.97.3])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7NNBEd03640
	for <linux-mips@oss.sgi.com>; Thu, 23 Aug 2001 16:11:14 -0700
Received: (qmail 24922 invoked from network); 23 Aug 2001 23:11:09 -0000
Received: from ocs3.ocs-net (192.168.255.3)
  by mail.ocs.com.au with SMTP; 23 Aug 2001 23:11:09 -0000
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Ralf Baechle <ralf@uni-koblenz.de>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.5: __dbe_table iteration #2 
In-reply-to: Your message of "Thu, 23 Aug 2001 18:52:45 +0200."
             <Pine.GSO.3.96.1010823164555.21718C-100000@delta.ds2.pg.gda.pl> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 24 Aug 2001 09:11:09 +1000
Message-ID: <17182.998608269@ocs3.ocs-net>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 23 Aug 2001 18:52:45 +0200 (MET DST), 
"Maciej W. Rozycki" <macro@ds2.pg.gda.pl> wrote:
>On Thu, 23 Aug 2001, Keith Owens wrote:
>> The definition of struct archdata in kernel and modutils can be
>> different, a new kernel layout with an old modutils is legal but fatal
>> unless you code for it.  The correct test for archdata is
>> 
>> if (!mod_member_present(mp, archdata_start) ||
>>     (mp->archdata_end - mp->archdata_start) <=
>>      offsetof(struct archdata, dbe_table_end))
>> 	continue;
> Hmm, your suggested code checks if the passed struct is long enough for
>dbe_table_start only -- what about dbe_table_end?  The following code: 

If archdata_end-archdata_start <= offsetof(dbe_table_end) then archdata
is too small to contain the first byte of dbe_table_end, skip the
archdata.  If archdata is large enough to contain the first byte of
dbe_table_end, assume that it contains all of dbe_table_end.

>While modutils as released won't ever pass a smaller
>struct, someone may modify them or use another program to invoke
>init_module(), so we need to protect the kernel against bogus data. 

You have to be root to call init_module() or run insmod, root can do a
lot more damage than passing an invalid structure size.  This type of
test is not to catch malicious code, it is to detect that the user is
running an old modutils with a smaller archdata than the kernel can
handle.

You are correct that modutils as released will never pass a smaller
archdata struct for mips so strictly speaking this test is superfluous.
However this type of code gets cut and pasted so I want size checking
on all archdata, when it is copied the developer has to think about
changing the test instead of forgetting to add a test.

Your suggested code works just as well but is less readable.  Go with
either.

>> The rest of the code looks OK, except it needs a global change of
>> arch_init_module: to module_arch_init: to match the macro name.
>
> OK, I'll do it.  It should have been done for ia64 in the first place.
>Or should it be changed into "<arch>_init_module" to match functions' real
>names?

Leave it as module_arch_init, it tells us how the code was called.

>> Do you have the corresponding modutils patch or shall I do it? 
>
> I've send it to you separately just after the kernel patch.  Should I
>resend it? 

No thanks, I found it.
