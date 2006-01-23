Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2006 14:08:03 +0000 (GMT)
Received: from smtp104.biz.mail.re2.yahoo.com ([206.190.52.173]:56710 "HELO
	smtp104.biz.mail.re2.yahoo.com") by ftp.linux-mips.org with SMTP
	id S3458584AbWAWOHo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Jan 2006 14:07:44 +0000
Received: (qmail 71324 invoked from network); 23 Jan 2006 14:11:51 -0000
Received: from unknown (HELO ?192.168.2.27?) (dan@embeddedalley.com@69.21.252.132 with plain)
  by smtp104.biz.mail.re2.yahoo.com with SMTP; 23 Jan 2006 14:11:51 -0000
In-Reply-To: <20060121210511.GD3456@linux-mips.org>
References: <20060119174600.GT19398@stusta.de> <20060121210511.GD3456@linux-mips.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2edd3641fe1cb18d25e35abe40de5d4e@embeddedalley.com>
Content-Transfer-Encoding: 7bit
Cc:	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
	Adrian Bunk <bunk@stusta.de>, perex@suse.cz,
	linux-mips@linux-mips.org
From:	Dan Malek <dan@embeddedalley.com>
Subject: Re: RFC: OSS driver removal, a slightly different approach
Date:	Mon, 23 Jan 2006 09:11:50 -0500
To:	Ralf Baechle <ralf@linux-mips.org>
X-Mailer: Apple Mail (2.623)
Return-Path: <dan@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10058
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddedalley.com
Precedence: bulk
X-list: linux-mips


On Jan 21, 2006, at 4:05 PM, Ralf Baechle wrote:

> On Thu, Jan 19, 2006 at 06:46:00PM +0100, Adrian Bunk wrote:
>
>> 3. no ALSA drivers for the same hardware
> [...]
>> SOUND_AU1550_AC97

The Au1550 should have an ALSA driver.  It was done
some time ago.  Perhaps we just didn't submit it to the
proper maintainer.  I'll track that down.

	-- Dan
