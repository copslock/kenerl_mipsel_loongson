Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7OFnYF17137
	for linux-mips-outgoing; Fri, 24 Aug 2001 08:49:34 -0700
Received: from [64.152.86.3] ([64.152.86.3])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7OFnVd17134
	for <linux-mips@oss.sgi.com>; Fri, 24 Aug 2001 08:49:31 -0700
Received: from mail.esstech.com by [64.152.86.3]
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 24 Aug 2001 15:50:15 UT
Received: from bud.austin.esstech.com ([193.5.206.3])
	by mail.esstech.com (8.8.8+Sun/8.8.8) with SMTP id IAA13758;
	Fri, 24 Aug 2001 08:48:16 -0700 (PDT)
Received: from GERALD.austin.esstech.com by bud.austin.esstech.com (SMI-8.6/SMI-SVR4)
	id KAA22489; Fri, 24 Aug 2001 10:49:46 -0500
Received: from mail.esstech.com by bud.austin.esstech.com
	(SMI-8.6/SMI-SVR4) id SAA16182; Thu, 23 Aug 2001 18:11:53 -0500
Received: from firewall.esstech.com (firewall.esstech.com [193.5.200.181])
	by mail.esstech.com (8.8.8+Sun/8.8.8) with SMTP id QAA07370 for
	<gerald.champagne@esstech.com>; Thu, 23 Aug 2001 16:10:18 -0700 (PDT)
Received: from oss.sgi.com ([216.32.174.27]) by firewall.esstech.com via
	smtpd (for mail.esstech.com [193.5.200.243]) with SMTP; 23 Aug 2001
	23:12:15 UT
Received: from localhost (mail@localhost) by oss.sgi.com (8.11.2/8.11.3)
	with SMTP id f7NNBUB03669; Thu, 23 Aug 2001 16:11:30 -0700
X-Authentication-Warning: oss.sgi.com: mail owned process doing -bs
Received: by oss.sgi.com (bulk_mailer v1.13); Thu, 23 Aug 2001 16:11:19
	-0700
Received: (from majordomo@localhost) by oss.sgi.com (8.11.2/8.11.3) id
	f7NNBJh03644 for linux-mips-outgoing; Thu, 23 Aug 2001 16:11:19 -0700
Received: from mail.ocs.com.au (ppp0.ocs.com.au [203.34.97.3]) by
	oss.sgi.com (8.11.2/8.11.3) with SMTP id f7NNBEd03640 for
	<linux-mips@oss.sgi.com>; Thu, 23 Aug 2001 16:11:14 -0700
Received: (qmail 24922 invoked from network); 23 Aug 2001 23:11:09 -0000
Received: from ocs3.ocs-net (192.168.255.3) by mail.ocs.com.au with SMTP;
	23 Aug 2001 23:11:09 -0000
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
Message-ID: <17182.998608269@ocs3.ocs-net>
X-UIDL: e5023c0d1d983e9276372ebe1c95ce8d
X-Mailer: Evolution/0.12 (Preview Release)
Date: 24 Aug 2001 10:49:31 -0500
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Message-ID: <20010824154931.LdK3fuB1tljRipLyoUSQ_r2ppvyBXpo8gZ4frU1KOr8@z>

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
