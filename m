Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Aug 2013 16:48:22 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:50106 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817904Ab3HHOsMnaZAX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Aug 2013 16:48:12 +0200
Message-ID: <5203AF83.30101@imgtec.com>
Date:   Thu, 8 Aug 2013 15:47:31 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-serial@vger.kernel.org>, <linux-mips@linux-mips.org>,
        Thomas Langer <thomas.langer@lantiq.com>
Subject: Re: [PATCH 1/2] serial: MIPS: lantiq: add clk_enable() call to driver
References: <1375968687-8704-1-git-send-email-blogic@openwrt.org>
In-Reply-To: <1375968687-8704-1-git-send-email-blogic@openwrt.org>
X-Enigmail-Version: 1.5.2
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.65]
X-SEF-Processed: 7_3_0_01192__2013_08_08_15_48_04
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37479
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

On 08/08/13 14:31, John Crispin wrote:
> From: Thomas Langer <thomas.langer@lantiq.com>
> 
> Enable the clock if one is present when setting up the console.
> 
> Signed-off-by: Thomas Langer <thomas.langer@lantiq.com>
> Acked-by: John Crispin <blogic@openwrt.org>
> ---
>  drivers/tty/serial/lantiq.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
> index 15733da..ce1ea35 100644
> --- a/drivers/tty/serial/lantiq.c
> +++ b/drivers/tty/serial/lantiq.c
> @@ -636,6 +636,9 @@ lqasc_console_setup(struct console *co, char *options)
>  
>  	port = &ltq_port->port;
>  
> +	if (ltq_port->clk)

I think that should be !IS_ERR(ltq_port->clk)? The same problem appears
to be elsewhere in that file too.

Cheers
James
