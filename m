Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jun 2006 18:15:09 +0100 (BST)
Received: from mail3.extremenetworks.com ([207.179.9.4]:14928 "EHLO
	extrgate1.extremenetworks.com") by ftp.linux-mips.org with ESMTP
	id S8133737AbWFMRPA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Jun 2006 18:15:00 +0100
Received: by extrgate1.extremenetworks.com with Internet Mail Service (5.5.2656.59)
	id <GWSVLXPF>; Tue, 13 Jun 2006 10:14:52 -0700
Message-ID: <4C8B0EA487B9554D910B0587CD91395C042F9A1F@sc-msexch-03.extremenetworks.com>
From:	Alex Oumanski <AOumanski@extremenetworks.com>
To:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Do I use right image?
Date:	Tue, 13 Jun 2006 10:06:33 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <AOumanski@extremenetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11723
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: AOumanski@extremenetworks.com
Precedence: bulk
X-list: linux-mips

I built linux 2.6 for sibyte1250 CPU, and see in the top directory image
named vmlinux
I try to boot this image by issuing:
pboot tftp://10.211.32.100/vmlinux "root=/dev/ram0 ro init=/linuxrc
pacman=1"
from the boot rom prompt of my board. The board hangs and I don't see a
single message ever coming out on my console.
Do I use right image?
