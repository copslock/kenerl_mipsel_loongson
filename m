Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Oct 2004 11:53:38 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:35155
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225228AbUJTKxc>; Wed, 20 Oct 2004 11:53:32 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CKE5m-0005s8-00; Wed, 20 Oct 2004 12:53:18 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CKE5k-0005bJ-00; Wed, 20 Oct 2004 12:53:16 +0200
Date: Wed, 20 Oct 2004 12:53:16 +0200
To: Andre.Messerschmidt@infineon.com
Cc: linux-mips@linux-mips.org
Subject: Re: Mozilla Firefox compile problem
Message-ID: <20041020105316.GE21691@rembrandt.csv.ica.uni-stuttgart.de>
References: <34A8108658DCCE4B8595675ABFD8172709FAFF@dusse201.eu.infineon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34A8108658DCCE4B8595675ABFD8172709FAFF@dusse201.eu.infineon.com>
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6117
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Andre.Messerschmidt@infineon.com wrote:
> 
> >This patch is broken and will only paper over the problem. Use 
> >the patch in https://bugzilla.mozilla.org/show_bug.cgi?id=258429
> >At least the firefox 0.93 in Debian mips works with it.
> 
> Thanks for the reply. With that patch I got two undefined macros
> (SETUP_GP and SAVE_GP). SETUP_GP was mentioned in the thread, but I
> could not find a definition for SAVE_GP. To go on I just defined it
> empty and continued to compile.
>
> Then I got the following error, which leaves me totally lost.

Well, not doing the SAVE_GP can have interesting effects. Its
definition should be found in /usr/include/sys/asm.h. For o32
it is

#define SAVE_GP(x) .cprestore x


Thiemo
