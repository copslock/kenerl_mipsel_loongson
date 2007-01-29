Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Jan 2007 23:57:09 +0000 (GMT)
Received: from tim.rpsys.net ([194.106.48.114]:206 "EHLO tim.rpsys.net")
	by ftp.linux-mips.org with ESMTP id S20037530AbXA2X5F (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 29 Jan 2007 23:57:05 +0000
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id l0TNrp3E006137;
	Mon, 29 Jan 2007 23:53:51 GMT
Received: from tim.rpsys.net ([127.0.0.1])
 by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 05679-09; Mon, 29 Jan 2007 23:53:48 +0000 (GMT)
Received: from max.rpnet.com (max.rpnet.com [192.168.1.15])
	(authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id l0TNrk4S006125
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Mon, 29 Jan 2007 23:53:46 GMT
Subject: Re: Advice on APM-EMU reunion
From:	Richard Purdie <rpurdie@rpsys.net>
To:	Rodolfo Giometti <giometti@enneenne.com>
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	linux-arm-kernel@lists.arm.linux.org.uk
In-Reply-To: <20070129230755.GA8705@enneenne.com>
References: <20070129230755.GA8705@enneenne.com>
Content-Type: text/plain
Date:	Mon, 29 Jan 2007 23:53:46 +0000
Message-Id: <1170114826.5833.139.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: amavisd-new at rpsys.net
Return-Path: <rpurdie@rpsys.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13853
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rpurdie@rpsys.net
Precedence: bulk
X-list: linux-mips

On Tue, 2007-01-30 at 00:07 +0100, Rodolfo Giometti wrote:
> Now I try on this list in order to have some advice if this could be a
> good idea and what about if I add a new class "apm_emu" on the sysfs
> support with proper registrations functions.

I'm not sure this is a good idea. As you're creating a new interface,
why not create something new/improved without the problems that
confining yourself to APM emulation brings?

Regards,

Richard
