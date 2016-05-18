Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 May 2016 23:09:39 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.126.131]:63595 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27030288AbcERVJgnfA1J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 May 2016 23:09:36 +0200
Received: from wuerfel.localnet ([78.42.132.4]) by mrelayeu.kundenserver.de
 (mreue005) with ESMTPSA (Nemesis) id 0LuYaa-1bkxpO3gQ4-00zqs2; Wed, 18 May
 2016 23:09:18 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Christian Lamparter <chunkeey@googlemail.com>
Cc:     John Youn <John.Youn@synopsys.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "a.seppala@gmail.com" <a.seppala@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: usb: dwc2: regression on MyBook Live Duo / Canyonlands since 4.3.0-rc4
Date:   Wed, 18 May 2016 23:09:14 +0200
Message-ID: <11140228.TZs2tGKv86@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <1569777.jHIobOl9fm@debian64>
References: <4231696.iL6nGs74X8@debian64> <573BAE58.1010206@synopsys.com> <1569777.jHIobOl9fm@debian64>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:gzYZj6CIJ1cmLflUvG8pmAxeXTGc2LBxY9gJRKnDKOgVMtKhNpu
 comL+8y5f3WJ2KvNH4Xcm5yuMPbjhJblRUXFmUBJodQ2C8P2U1rwvgzKuYUzHem9VQbt2lz
 eAUeGbqXK7QGVektjXkGPpeHWSZORHSmYZah3LfVprqTK+aRHFffHdlyzCWIHuixez8/+85
 sSCSAGZDpPYbbr/CK9QXg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ajWWwX5E2Pk=:C8jQac+9MbLkmYtXSGKsGO
 YGPqssrb62wN8irzLbsMiAllo5hgGKMNluHIIzbsTaqgdpgBcGQymm0JIqNHC0zHKZc+GHEqQ
 6SdmbXgPvbJ5Ks8V3P9rZta0iK5ZRKPsixEsrn1QPTgy4/WR90rXcJXZmpvW4jHR/DBJMMBQo
 pu2kfV/EBQecxeJnKzK32sjNLSYRL6k3aQqxs9I9h1OTl5IuWUrVaEGpN7YF1PiR53ORo4IRZ
 X2lZjbnLA8BMF0ySdm7AShvYct6rKLHgM/yjm0/UppXLTWwiJMGkGpQXHm3HUCpQTqnnJp838
 CuDfNM1anH4eN1OQd9W1hS/X9iVe39IMuV6MMbpUjhUKqGG8bm3j+tyJbRAomNGui1t7QPrGq
 SGlmAxiastso9VlK7YpEDPnWqUHUvJ8uSUaSqIbyJsZC/EhpOxs9fe2/IXzGeu5HB3E+TQdwv
 nCAPvxF11MQvhWxOLP9dB2MGuMWsHBQtqq7qeD9nDphqjumZ/MPm7brvNAyWTYL9BvrIa7+QM
 y9Tfk0gTzc0Rjd4CvFA3yLCE2gTLxrJtqLHdBjnFj9iJusdwnzRiIANfqYIS45+lGr48ATGnE
 /O36hlBMQADlmKxzwt8N0bu8p1uap5JIBJnEVcsEVvPrb6uMpY5Zn1bUsJtzwkgDhLSn4+pmz
 3NjHlxwr4SUlqMXzYAkSAQh6ZgNYrYxMKzH7lzlLwwdrGuSMheCfmE9pHxfq/pu2piUN/xaAM
 ekpMy46sMArIilqQJuwJXxakS0sF012gMhiQgw==
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53526
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

On Wednesday 18 May 2016 21:14:55 Christian Lamparter wrote:
> On Tuesday, May 17, 2016 04:50:48 PM John Youn wrote:
> > On 5/14/2016 6:11 AM, Christian Lamparter wrote:

> Hey, that's really nice of you to do that :-D. Please keep me in the
> loop (Cc) for those then. 
> 
> Yes, this needs definitely testing on all the affected ARCHs. 
> I've attached a diff to a updated version of the patch. It
> drops the special MIPS case (as requested by Arnd).

Ok, thanks!

> BTW, I looked into the ioread32_rep and iowrite32_rep again. I'm
> not entirely convinced that the hardware FIFOs are actually endian
> neutral. But I can't verify it since my Western Digital My Book Live
> only supports the host configuration (forces host mode), so I don't
> know what a device in dual-mode or peripheral do here.

I think it's highly unlikely that designware would have screwed up
their part in such an unusual way, by intentionally adding a
byte-reversal on something that is not connected to a 32-bit
register.

Note that the reason why ioread32_rep() doesn't swap is not that
the registers are endian neutral, but that they use endianess in
the same way that the memory does: If you want to look at the first
byte of a (theoretical) four-byte USB data packet, we read four
bytes from the FIFO register using __raw_readl() (a pointer dereference)
and store it to memory using a 32-bit write:

	*(u32 *)buffer = __raw_readl(FIFO);

Then we expect the first byte of the packet to be at the start:

	byte0 = *(u8*)buffer;

If you replace the __raw_readl() with ioread32(), it gets byteswapped
on big-endian *CPUs*, and then written to memory without an extra
swap. This means that now you get the wrong data depending on the
kernel endianess configuration, and independent of the device endianess.

If the big-endian mode of the dwc2 block indeed contains a byteswap
on the FIFO, that would mean not having to use ioread32_be() for
the FIFO, but using

fifo_read32(void *buffer)
{
	u32 data = __raw_readl(FIFO_ADDRESS);
	if (big_endian_registers)
		data = bswap32(data);
	*(u32*)buffer = data;
}

so we byteswap the FIFO contents back, regardless of the CPU
endianess. As I said, it's unlikely that the hardware is this broken,
but not impossible.

> The reason why I think it was broken is because there's a PIO copy
> to and from the HCFIFO(x) in dwc2_hc_write_packet and
> dwc2_hc_read_packet access in the hcd.c file as well... And there,
> the code was using the dwc2_readl and dwc2_writel to access the data.

Well, we know for a fact that those functions get endianess wrong,
see dwc2_hc_write_packet:

        if (((unsigned long)data_buf & 0x3) == 0) {
                /* xfer_buf is DWORD aligned */
                for (i = 0; i < dword_count; i++, data_buf++)
                        dwc2_writel(*data_buf, data_fifo);
        } else {
                /* xfer_buf is not DWORD aligned */
                for (i = 0; i < dword_count; i++, data_buf++) {
                        u32 data = data_buf[0] | data_buf[1] << 8 |
                                   data_buf[2] << 16 | data_buf[3] << 24;
                        dwc2_writel(data, data_fifo);
                }
        }

On big-endian machines, unaligned case performs a byte swap while the
aligned case does not. My best guess is that this function never
got called on either the MIPS machine that first got the fix or
your PowerPC machine.

Another possibility is that you are right that there is a byteswap
on the FIFO register in big-endian mode, and that this function
always gets unaligned buffers, so the byteswap here cancels out
the byteswap on the FIFO when both the CPU and the device are
big-endian.

> -	if (((unsigned long)data_buf & 0x3) == 0) {
> -		/* xfer_buf is DWORD aligned */
> -		for (i = 0; i < dword_count; i++, data_buf++)
> -			dwc2_writel(hsotg, *data_buf, HCFIFO(chan->hc_num));
> -	} else {
> -		/* xfer_buf is not DWORD aligned */
> -		for (i = 0; i < dword_count; i++, data_buf++) {
> -			u32 data = data_buf[0] | data_buf[1] << 8 |
> -				   data_buf[2] << 16 | data_buf[3] << 24;
> -			dwc2_writel(hsotg, data, HCFIFO(chan->hc_num));
> -		}
> -	}
> +	dwc2_writel_rep(hsotg, HCFIFO(chan->hc_num), data_buf, byte_count);
>  

and here you are dropping the byteswap on big-endian.

	Arnd
