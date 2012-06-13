Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jun 2012 16:11:13 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:55034 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903760Ab2FMOLJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 13 Jun 2012 16:11:09 +0200
Message-ID: <4FD89F51.5020200@openwrt.org>
Date:   Wed, 13 Jun 2012 16:10:25 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111114 Icedove/3.1.16
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH 1/8] MIPS: BCM63XX: move flash registration out of board_bcm963xx.c
References: <1339489425-19037-1-git-send-email-jonas.gorski@gmail.com> <1339489425-19037-2-git-send-email-jonas.gorski@gmail.com> <20120613134801.GA5516@linux-mips.org> <2177534.JpaDVG7JnB@flexo> <20120613135953.GB6839@linux-mips.org>
In-Reply-To: <20120613135953.GB6839@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 33625
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 13/06/12 15:59, Ralf Baechle wrote:
>>> > > And the grand cure for that sort of issue is FDT - we by now have built
>>> > > big deserts of code just registering platform devices like this..  See
>>> > > John Crispin's Lantiq work or David's Cavium code for FDT examples.
>> > 
>> > I have some patches to convert bcm63xx to FDT but that is still work in 
>> > progress, and I don't want them to hold support for newer BCM63xx CPUs.
> Oh absolutely.  I'm just nagging to make it clear to everybody into what
> direction the world is moving.
>
FDT FTW :-)
