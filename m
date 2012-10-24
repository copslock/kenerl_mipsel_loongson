Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Oct 2012 10:26:12 +0200 (CEST)
Received: from smtp-out-141.synserver.de ([212.40.185.141]:1156 "EHLO
        smtp-out-137.synserver.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6823021Ab2JXIZ27IlWA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Oct 2012 10:25:28 +0200
Received: (qmail 27114 invoked by uid 0); 24 Oct 2012 08:25:24 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@metafoo.de
X-SynServer-PPID: 27055
Received: from p5491eca6.dip.t-dialin.net (HELO ?192.168.0.176?) [84.145.236.166]
  by 217.119.54.96 with AES256-SHA encrypted SMTP; 24 Oct 2012 08:25:24 -0000
Message-ID: <5087A5FA.70204@metafoo.de>
Date:   Wed, 24 Oct 2012 10:25:30 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.9) Gecko/20121014 Icedove/10.0.9
MIME-Version: 1.0
To:     "Steven J. Hill" <sjhill@realitydiluted.com>
CC:     linux-mips@linux-mips.org
Subject: Re: [RFC 00/13] MIPS: JZ4750D: Add base support for Ingenic JZ4750D
 SOC
References: <1351014241-3207-1-git-send-email-antonynpavlov@gmail.com> <5086DEBB.1030506@metafoo.de> <5086F6AE.4030105@realitydiluted.com>
In-Reply-To: <5086F6AE.4030105@realitydiluted.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 34767
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
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

On 10/23/2012 09:57 PM, Steven J. Hill wrote:
> On 10/23/2012 01:15 PM, Lars-Peter Clausen wrote:
>> As for the renaming I'm not so sure if it is really necessary. We often
>> stick we the name for the driver or architecture version which was first
>> supported by the kernel and add note in Kconfig and comments that the
>> driver also supports other version/variants of the peripheral or SoC.
> 
> We currently have 'jz4740' and 'jz4770' directories. I think putting the
> jz4750d code into 'jz4740' is a good idea too. Perhaps someday a 'jz47xx'
> directory could be possible, but not sure it is worth the work.

In my opinion it is more effort to maintain these as separate
subarchitectures. The peripherals are just to similar. Making a change to
one of the jz4740 drivers will likely require the same change to the jz4770
driver.

- Lars
