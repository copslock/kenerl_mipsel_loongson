Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Jan 2011 10:50:11 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:59035 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490980Ab1AFJuI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 6 Jan 2011 10:50:08 +0100
Message-ID: <4D25908E.9070509@openwrt.org>
Date:   Thu, 06 Jan 2011 10:51:10 +0100
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.12) Gecko/20100913 Icedove/3.0.7
MIME-Version: 1.0
To:     Jamie Iles <jamie@jamieiles.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 05/10] MIPS: lantiq: add watchdog support
References: <1294257379-417-1-git-send-email-blogic@openwrt.org> <1294257379-417-6-git-send-email-blogic@openwrt.org> <20110105234910.GD2112@gallagher>
In-Reply-To: <20110105234910.GD2112@gallagher>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28864
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips

On 06/01/11 00:49, Jamie Iles wrote:
> I think you need a clk_put() here too to balance the clk_get() in the 
> probe method so you'll need to keep a reference to the clk.
>
>   

Hi Jamie,

i will fold your suggestions into the series.

the clk.c/h implementation on the lantiq target is very simple. it only
allows to read the static rates of the 3 clocks. clk_put is implemented
as follows

void
clk_put(struct clk *clk)
{
    /* not used */
}
EXPORT_SYMBOL(clk_put);

so in theory you are right and we should call that function, however as
it is only a stub and the driver is only used by the lantiq target i
think it is save to leave out the clk_put(); call. we could however put
a commet in the code to make this clear (same as with the clk_enable()
not being needed as the clocks are always running)

Thanks,
John
