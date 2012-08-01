Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Aug 2012 11:52:40 +0200 (CEST)
Received: from mailout-de.gmx.net ([213.165.64.23]:57636 "HELO
        mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with SMTP id S1903828Ab2HAJwc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Aug 2012 11:52:32 +0200
Received: (qmail invoked by alias); 01 Aug 2012 09:52:26 -0000
Received: from dslb-092-075-146-087.pools.arcor-ip.net (EHLO [192.168.0.9]) [92.75.146.87]
  by mail.gmx.net (mp035) with SMTP; 01 Aug 2012 11:52:26 +0200
X-Authenticated: #10250065
X-Provags-ID: V01U2FsdGVkX1/ydTtygavy2b/G67q18FQh3kw3uqlxcgHjTWC8GW
        Vssdina1GS+k3W
Message-ID: <5018FC58.10605@gmx.de>
Date:   Wed, 01 Aug 2012 09:52:24 +0000
From:   Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20120613 Icedove/3.0.11
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@linux-mips.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] Fix newport con crashes
References: <20120730105416.DBB961D1CF@solo.franken.de> <20120730133447.GA29993@linux-mips.org>
In-Reply-To: <20120730133447.GA29993@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
X-archive-position: 34014
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: FlorianSchandinat@gmx.de
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

On 07/30/2012 01:34 PM, Ralf Baechle wrote:
> On Mon, Jul 30, 2012 at 12:54:16PM +0200, Thomas Bogendoerfer wrote:
> 
>> Because of commit e84de0c61905030a0fe66b7210b6f1bb7c3e1eab
>> [MIPS: GIO bus support for SGI IP22/28] newport con is now taking over
>> console from dummy con, therefore it's necessary to resize the VC to
>> the correct size to avoid crashes and garbage on console
>>
>> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> 
> I've applied your patch to master and the affected -stable branches of the
> lmo git tree.
> 
> Florian, since this is a driver specific to certain MIPS platforms I'd like
> to merge it through the MIPS tree with your ack, if that's ok?

Yes, sounds good to me. The patch looks good.


Best regards,

Florian Tobias Schandinat
