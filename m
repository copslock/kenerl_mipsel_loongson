Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jun 2003 11:13:45 +0100 (BST)
Received: from firewall.spacetec.no ([IPv6:::ffff:192.51.5.5]:62729 "EHLO
	spacetec.no") by linux-mips.org with ESMTP id <S8224827AbTFJKNn>;
	Tue, 10 Jun 2003 11:13:43 +0100
Message-Id: <200306101013.h5AADRA9002456@pallas.spacetec.no>
From: tor@spacetec.no (Tor Arntsen)
Date: Tue, 10 Jun 2003 12:13:25 +0200
In-Reply-To: Jeff Baitis <baitisj@evolution.com>
       "Re: Building a stand-alone FS on a very limited flash (newbie  question)" (Jun  9, 20:08)
To: baitisj@evolution.com, Baruch Chaikin <bchaikin@il.marvell.com>
Subject: Re: Building a stand-alone FS on a very limited flash (newbie  question)
Cc: linux-mips@linux-mips.org, Rabeeh Khoury <rabeeh@galileo.co.il>
Return-Path: <tor@spacetec.no>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2577
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tor@spacetec.no
Precedence: bulk
X-list: linux-mips

On Jun 9, 20:08, Jeff Baitis wrote:
>I made a mistake. I'm sorry, these projects use *busybox*. Don't know
>if they use UClibC or not. Some wires in my brain got crossed.
[...]

You can combine busybox and UClibC to create a very small Unix file system holding 
most of the tools you would want.  I made myself a single-floppy feature-full rescue
root disk for my x86 system using busybox and UClibC.  Looks like one good way
to solve the space problem described below.

-Tor

>> On Mon, Jun 09, 2003 at 07:37:19PM +0200, Baruch Chaikin wrote:
>> > Hi all,
>> > 
>> > I'm using MIPS kernel 2.4.18 with NFS file system mounted on a RedHat 
>> > machine. This works fine, but is unsuitable for system deployment. Do 
>> > you have hints for me where to start, in order to put the file system on 
>> > flash? The platform I'm using is very limited - only one MTD block of 
>> > 2.5 MB is available for the file system, out of a 4 MB flash:
>> >     0.5 MB is allocated for the firmware code
>> >     1.0 MB for the compressed kernel image
>> >     2.5 MB for the (compressed?) file system
[...]
