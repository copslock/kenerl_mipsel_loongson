Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Oct 2005 14:41:30 +0100 (BST)
Received: from mp1-smtp-3.eutelia.it ([62.94.10.163]:8870 "EHLO
	smtp.eutelia.it") by ftp.linux-mips.org with ESMTP id S8133653AbVJINlI
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 9 Oct 2005 14:41:08 +0100
Received: from voyager (ip-96-162.sn2.eutelia.it [83.211.96.162])
	by smtp.eutelia.it (Eutelia) with ESMTP id 53D0517F749
	for <linux-mips@linux-mips.org>; Sun,  9 Oct 2005 15:41:07 +0200 (CEST)
Received: by voyager (Postfix, from userid 1000)
	id E09331A5E6A; Sun,  9 Oct 2005 15:41:06 +0200 (CEST)
Date:	Sun, 9 Oct 2005 15:41:06 +0200
From:	Carlo Perassi <carlo@linux.it>
To:	linux-mips@linux-mips.org
Subject: rfc about an uncommented string
Message-ID: <20051009134106.GB9091@voyager>
Reply-To: carlo@linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Return-Path: <carlo@linux.it>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9203
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carlo@linux.it
Precedence: bulk
X-list: linux-mips

Hi.
As suggested (*) by Arthur Othieno on the kernel-janitors mailing list,
I bounce here this email for collecting comments.
The old email refers to 2.6.13-rc6 but the code is still the same on
2.6.14-rc3.
Thank you.

Hi.

I'd like to collect some comments about the following code
segment I found in
linux-2.6.13-rc6/arch/mips/ite-boards/generic/it8172_setup.c
(the "^^^" sequence is not mine, it's in the code)

#ifdef CONFIG_SERIO_I8042
/*
 * According to the ITE Special BIOS Note for waking up the
 * keyboard controller...
 */
static int init_8712_keyboard(void)
{
	unsigned int cmd_port = 0x14000064;
	unsigned int data_port = 0x14000060;
	                         ^^^^^^^^^^^
	Somebody here doesn't grok the concept of io ports.

(*)
http://lists.osdl.org/pipermail/kernel-janitors/2005-August/004704.html
http://lists.osdl.org/pipermail/kernel-janitors/2005-August/004705.html
http://lists.osdl.org/pipermail/kernel-janitors/2005-August/004707.html
http://lists.osdl.org/pipermail/kernel-janitors/2005-October/004955.html

-- 
Carlo Perassi - http://www.linux.it/~carlo/
