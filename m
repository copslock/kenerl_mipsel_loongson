Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2014 10:02:41 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.17.10]:55810 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013493AbaKLJCkSr-KE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Nov 2014 10:02:40 +0100
Received: from wuerfel.localnet (HSI-KBW-149-172-15-242.hsi13.kabel-badenwuerttemberg.de [149.172.15.242])
        by mrelayeu.kundenserver.de (node=mreue101) with ESMTP (Nemesis)
        id 0MduSz-1XePD81e3B-00PaOF; Wed, 12 Nov 2014 10:02:23 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org,
        tushar.behera@linaro.org, daniel@zonque.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
        grant.likely@linaro.org, f.fainelli@gmail.com, mbizon@freebox.fr,
        jogo@openwrt.org, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH/RFC 4/8] serial: pxa: Add fifo-size and {big,native}-endian properties
Date:   Wed, 12 Nov 2014 10:02:22 +0100
Message-ID: <3584682.xS3Glp9BQh@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <1415781993-7755-5-git-send-email-cernekee@gmail.com>
References: <1415781993-7755-1-git-send-email-cernekee@gmail.com> <1415781993-7755-5-git-send-email-cernekee@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V02:K0:EUtrj0RR9lWLt/EM9FUVt62b3xXxuzuxkiIgUmCQtwE
 Qg0kWMHVvSJ1TXs3uMt4AXOId9BhifRhz0Qloc4NQYkZlo5RU/
 WsejzxhS8ysDnRMbKN3DLj79gG8TMfueHXOmZmM2MlQFbXYzAS
 mB27ZpCuHSLB/LVoN5IrFRjzokDNdQLGpoeKlOJ/sHlrg+wUjI
 vCAv3+h3tQAuv2Rou94VfcwE5b0f+ProahKIUL6Xqq7PHGzUkb
 Mk4r5ChD1NFVg6Ofs9c5gmaU6SImjrLgx2Azotd/VRo8OQjNFH
 muuvS0/5EqQR1bvBAhdC2DOo2EmGYKXaGK69ikwvYoBg4hBwBf
 yn9rjw0QaoRmjpSWiq6w=
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44038
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Wednesday 12 November 2014 00:46:29 Kevin Cernekee wrote:
> diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
> index 21b7d8b..78ed7ee 100644
> --- a/drivers/tty/serial/pxa.c
> +++ b/drivers/tty/serial/pxa.c
> @@ -60,13 +60,19 @@ struct uart_pxa_port {
>  static inline unsigned int serial_in(struct uart_pxa_port *up, int offset)
>  {
>         offset <<= 2;
> -       return readl(up->port.membase + offset);
> +       if (!up->port.big_endian)
> +               return readl(up->port.membase + offset);
> +       else
> +               return ioread32be(up->port.membase + offset);
>  }

How about making this a different UPIO type and using UPIO_MEM32/UPIO_MEM32BE
to tell the difference rather than a separate flag?

	Arnd
