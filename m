Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6VHfCRw007331
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 31 Jul 2002 10:41:12 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6VHfCnP007330
	for linux-mips-outgoing; Wed, 31 Jul 2002 10:41:12 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from hermod.qsicorp.com (mail.qsicorp.com [216.190.147.34])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6VHf6Rw007317
	for <linux-mips@oss.sgi.com>; Wed, 31 Jul 2002 10:41:07 -0700
Received: from localhost (localhost.localdomain [127.0.0.1])
	by hermod.qsicorp.com (Postfix) with ESMTP id 0F68C17088
	for <linux-mips@oss.sgi.com>; Wed, 31 Jul 2002 11:42:38 -0600 (MDT)
Received: from hermod.qsicorp.com ([127.0.0.1]) by localhost (hermod.qsicorp.com [127.0.0.1]) (amavisd-new) with ESMTP id 16726-04 for <linux-mips@oss.sgi.com>; Wed, 31 Jul 2002 11:42:36 -0000 (MDT)
Received: from qsicorp.com (computer195.qsicorp.com [216.190.147.195])
	by hermod.qsicorp.com (Postfix) with ESMTP id 4D59F17086
	for <linux-mips@oss.sgi.com>; Wed, 31 Jul 2002 11:42:36 -0600 (MDT)
Message-ID: <3D482FF3.11F8CA0B@qsicorp.com>
Date: Wed, 31 Jul 2002 11:44:03 -0700
From: Ryan Martindale <ryan@qsicorp.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.9-31custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: Problem with gp
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by amavisd-new amavisd-new-20020630
X-Razor-id: 688190f04f48faa4d4b70d3dfe77fb7bc42e500f
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I seem to be having troubles getting the CVS snapshot up and running.
I've debugged it, and it seems that the problem stems from the fact that
$28 (gp) is modified in the SAVE_SOME macro to point to somewhere on the
stack (not sure why this occurs). Anyways, when I get my first system
timetick interrupt, the update_process_times function fails to get the a
valid task structure pointer and wipes out. Why are we adjusting gp
here, since it is explicitly expected to hold only current_thread_info?

(in stackframe.h)

...
		.macro	SAVE_SOME

...

		sw	$25, PT_R25(sp)
		sw	$28, PT_R28(sp)
		sw	$31, PT_R31(sp)
		ori	$28, sp, 0x1fff
		xori	$28, 0x1fff

...


Ryan
