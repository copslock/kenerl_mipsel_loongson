Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 May 2009 18:56:13 +0100 (BST)
Received: from smtp1-g21.free.fr ([212.27.42.1]:40511 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20022131AbZEYR4H (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 25 May 2009 18:56:07 +0100
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id A1B1F940176;
	Mon, 25 May 2009 19:56:01 +0200 (CEST)
Received: from [192.168.1.189] (cac94-1-81-57-151-96.fbx.proxad.net [81.57.151.96])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 7996E940157;
	Mon, 25 May 2009 19:55:58 +0200 (CEST)
Message-ID: <4A1ADBAE.6070101@free.fr>
Date:	Mon, 25 May 2009 19:55:58 +0200
From:	matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.19) Gecko/20081204 Iceape/1.1.14 (Debian-1.1.14-1)
MIME-Version: 1.0
To:	Michael Buesch <mb@bu3sch.de>
CC:	linux-mips@linux-mips.org, netdev@vger.kernel.org,
	Daniel Mueller <daniel@danm.de>
Subject: Re: [PATCH] bc47xx : fix ssb irq setup
References: <4A11DBD4.7070706@free.fr> <200905191519.59193.mb@bu3sch.de>
In-Reply-To: <200905191519.59193.mb@bu3sch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <castet.matthieu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22959
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: castet.matthieu@free.fr
Precedence: bulk
X-list: linux-mips

Michael Buesch wrote:
> On Tuesday 19 May 2009 00:06:12 matthieu castet wrote:
>> Hi,
>>
>>
>> [1] http://www.danm.de/files/src/bcm5365p/REPORTED_DEVICES
>>
>> Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>
>>
> 
> If this works on all devices, I'm OK with this. Please submit to linville@tuxdriver.com
> You can add my ack.
> 
Well I have only a wl500gd.
I have submit it on openwrt project in order to test in more devices.


Matthieu
