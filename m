Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id FAA943758 for <linux-archive@neteng.engr.sgi.com>; Wed, 10 Dec 1997 05:37:54 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id FAA29775 for linux-list; Wed, 10 Dec 1997 05:36:09 -0800
Received: from meteor.nsg.sgi.com (meteor.nsg.sgi.com [134.14.162.53]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id FAA29729 for <linux@engr.sgi.com>; Wed, 10 Dec 1997 05:36:04 -0800
Received: (from hakamada@localhost) by meteor.nsg.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id WAA09888; Wed, 10 Dec 1997 22:35:39 +0900
Message-Id: <199712101335.WAA09888@meteor.nsg.sgi.com>
To: linux@cthulhu.engr.sgi.com
Subject: Mount ext2 filesystem.
X-Mailer: Mew version 1.70 on XEmacs 20.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Wed, 10 Dec 1997 22:35:39 +0900
From: Takeshi Hakamada <hakamada@meteor.nsg.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi all,

I'm working on my R5000 Indy can mount second disk as root filesystem.
I've created ext2 filesystem from my i486-based Linux box and I connected
it to my Indy as the second drive. Then I booted vmlinux-indy-2.1.67
(made by Ralf) from the first disk on my Indy, mounted nfs-root filesystem
which is made by Ralf I know.
I can mount both the first disk(efs) and the second one(ext2).

However, when I try to invoke rpm which is made by Alan(libc/ld workaround
version), I get efs read error as follows:

efs: read error in indirect extents
attempt to access beyond end of device
08:01 rw=0, want=1207011792, limit=1965937

Do you think something wrong with my IRIX efs partition? When I mount
IRIX root partition, I can invoke some IRIX command(like ls, cp).

Anyway, why root-be-0.00.cpio.gz doesn't contain rpm binary?
I think rpm binary should be in root-be-0.00.cpio.gz.


Thanks,
--
Takeshi Hakamada                  
Nihon Silicon Graphics Cray
E-mail: hakamada@nsg.sgi.com, URL: http://reality.sgi.com/hakamada_nsg/
Phone: +81-45-682-3712, Fax: +81-45-682-0856
Voice mail: (internal)822-1300, (external)+81-3-5488-1863-1300
