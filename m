Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Aug 2012 21:06:26 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:46644 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903648Ab2HVTGV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 22 Aug 2012 21:06:21 +0200
Message-ID: <50352D58.6040201@openwrt.org>
Date:   Wed, 22 Aug 2012 21:04:56 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111114 Icedove/3.1.16
MIME-Version: 1.0
To:     Mark Brown <broonie@opensource.wolfsonmicro.com>
CC:     spi-devel-general@lists.sourceforge.net, linux-mips@linux-mips.org,
        Daniel Schwierzeck <daniel.schwierzeck@googlemail.com>
Subject: Re: [PATCH] SPI: MIPS: lantiq: adds spi-xway
References: <1345103821-12543-1-git-send-email-blogic@openwrt.org> <20120822185944.GD7995@opensource.wolfsonmicro.com>
In-Reply-To: <20120822185944.GD7995@opensource.wolfsonmicro.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 34343
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

On 22/08/12 20:59, Mark Brown wrote:
>> +       if (of_machine_is_compatible("lantiq,ase"))
>> > +               master->num_chipselect = 3;
>> > +       else
>> > +               master->num_chipselect = 6;
> This is very suspicious - why is this being done based on the machine
> rather than based on the IP?  Surely there can be machines with this SoC
> on which aren't compatible with whatever (reference?) board this is
> matching on.  I'd expect that the driver would have multiple compatible
> strings which it uses to distinguish the capabilities of the IP.
>
> Though actually the driver never reads this value so perhaps the code
> can just be deleted and we rely on the fact that if the /CS isn't
> physically present nobody's going to hook it up on a board so just
> always set it to 6?
>
Thanks for the review i will rework the driver, add a binding doc and
resend ...

is there a equivalent of of_machine_is_compatible for IP ?

John
