Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Apr 2003 11:18:02 +0100 (BST)
Received: from port48.ds1-vbr.adsl.cybercity.dk ([IPv6:::ffff:212.242.58.113]:65090
	"EHLO valis.localnet") by linux-mips.org with ESMTP
	id <S8225211AbTDKKSB>; Fri, 11 Apr 2003 11:18:01 +0100
Received: from murphy.dk (brm@brian.localnet [10.0.0.2])
	by valis.localnet (8.12.7/8.12.7/Debian-2) with ESMTP id h3BAHqBs002490;
	Fri, 11 Apr 2003 12:17:53 +0200
Message-ID: <3E969650.9070107@murphy.dk>
Date: Fri, 11 Apr 2003 12:17:52 +0200
From: Brian Murphy <brian@murphy.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: Hartvig Ekner <hartvig@ekner.info>
CC: linux-mips@linux-mips.org
Subject: Re: ext3 under MIPS?
References: <3E954651.C7AECB90@ekner.info> <20030410154050.GI5242@lug-owl.de> <3E95D16D.1671BA5A@ekner.info> <20030411064754.GM5242@lug-owl.de> <3E969362.B50934A@ekner.info>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <brian@murphy.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1991
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brian@murphy.dk
Precedence: bulk
X-list: linux-mips

Hartvig Ekner wrote:

>Now I'm beginning to suspect that my conversion from ext2 to ext3 (tune2fs -j on a running system, and
>just modifying ext2 to ext3 in fstab) is somehow not correct, or something else which I overlooked?
>How did you guys (the ones without any ext3 problems) initially get the ext3 root partition in place
>(was it born as ext3 or converted from ext2?) and anything special one needs to do in fstab?
>
>  
>
I did the same: "tune2fs -j" also on a running system, nothing special 
in fstab:

/dev/hda2       /               ext3            defaults        0       1

/Brian
