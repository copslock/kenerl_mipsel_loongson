Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7N1peO11422
	for linux-mips-outgoing; Wed, 22 Aug 2001 18:51:40 -0700
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7N1pad11418
	for <linux-mips@oss.sgi.com>; Wed, 22 Aug 2001 18:51:36 -0700
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id SAA03581
	for <linux-mips@oss.sgi.com>; Wed, 22 Aug 2001 18:51:35 -0700 (PDT)
	mail_from (kaos@ocs.com.au)
Received: from kao2.melbourne.sgi.com (kao2.melbourne.sgi.com [134.14.55.180]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id LAA06795; Thu, 23 Aug 2001 11:49:53 +1000
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Ralf Baechle <ralf@uni-koblenz.de>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.5: __dbe_table iteration #2 
In-reply-to: Your message of "Mon, 20 Aug 2001 15:57:21 +0200."
             <Pine.GSO.3.96.1010820150047.3562D-100000@delta.ds2.pg.gda.pl> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 23 Aug 2001 11:49:53 +1000
Message-ID: <19339.998531393@kao2.melbourne.sgi.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 20 Aug 2001 15:57:21 +0200 (MET DST), 
"Maciej W. Rozycki" <macro@ds2.pg.gda.pl> wrote:
>+	for (mp = module_list; mp != NULL; mp = mp->next) {
>+		if (!mod_member_present(mp, archdata_start) ||
>+		    !mp->archdata_start)
>+			continue;
>+		ap = (struct archdata *)(mp->archdata_start);

The definition of struct archdata in kernel and modutils can be
different, a new kernel layout with an old modutils is legal but fatal
unless you code for it.  The correct test for archdata is

if (!mod_member_present(mp, archdata_start) ||
    (mp->archdata_end - mp->archdata_start) <=
     offsetof(struct archdata, dbe_table_end))
	continue;

Do not use archdata unless it is at least large enough to contain
dbe_table_end.  That test also takes care of NULL pointers, end - start
== 0 for NULL.

The rest of the code looks OK, except it needs a global change of
arch_init_module: to module_arch_init: to match the macro name.

Do you have the corresponding modutils patch or shall I do it?
