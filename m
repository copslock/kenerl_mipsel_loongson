Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Sep 2003 06:34:52 +0100 (BST)
Received: from alcor.twinsun.com ([IPv6:::ffff:198.147.65.9]:44623 "EHLO
	alcor.twinsun.com") by linux-mips.org with ESMTP
	id <S8225370AbTIKFeU>; Thu, 11 Sep 2003 06:34:20 +0100
Received: from green.twinsun.com ([192.54.239.71])
	by alcor.twinsun.com (8.12.6/8.12.6) with ESMTP id h8B5YFgr031213
	for <linux-mips@linux-mips.org>; Wed, 10 Sep 2003 22:34:16 -0700 (PDT)
Received: from shade.twinsun.com (shade.twinsun.com [192.54.239.27])
	by green.twinsun.com (8.11.7+Sun/8.11.7) with SMTP id h8B5YEW02195
	for <linux-mips@linux-mips.org>; Wed, 10 Sep 2003 22:34:14 -0700 (PDT)
Received: from green.twinsun.com ([192.54.239.71])
 by shade.twinsun.com (SAVSMTP 3.1.0.29) with SMTP id M2003091022341402511
 for <linux-mips@linux-mips.org>; Wed, 10 Sep 2003 22:34:14 -0700
Received: from mae.twinsun.com (mae.twinsun.com [192.207.224.40])
	by green.twinsun.com (8.11.7+Sun/8.11.7) with SMTP id h8B5YEW02192
	for <linux-mips@linux-mips.org>; Wed, 10 Sep 2003 22:34:14 -0700 (PDT)
Received: by mae.twinsun.com (sSMTP sendmail emulation); Wed, 10 Sep 2003 22:34:14 -0700
To: linux-mips@linux-mips.org
Subject: TX49 NAND supported?
From: Junio C Hamano <junkio@twinsun.com>
Date: Wed, 10 Sep 2003 22:34:14 -0700
Message-ID: <7vllsvj3c9.fsf@mae.twinsun.com>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <junkio@twinsun.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3159
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: junkio@twinsun.com
Precedence: bulk
X-list: linux-mips

Does anybody have a working tx4925 NAND driver that can be used
with the latest mtd from infradead CVS?  I have located a copy
of tx4925ndfmc.c with 2002 timestamp by Toshiba Corporation
(GPLv2) but it appears to use an API incompatible with the
current one.  Among other things, it seems to think that struct
nand_chip has fields like IO_ADDR, CTRL_ADDR, CLE, ALE, NCE,
ioread, iowrite, etc, and appears to predate the following
change in include/linux/mtd/nand.h:

 *   10-29-2001 TG	changed nand_chip structure to support 
 *			hardwarespecific function for accessing control lines
