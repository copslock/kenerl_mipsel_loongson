Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Mar 2003 20:17:44 +0100 (BST)
Received: from pasmtp.tele.dk ([IPv6:::ffff:193.162.159.95]:12563 "EHLO
	pasmtp.tele.dk") by linux-mips.org with ESMTP id <S8225192AbTCaTRm>;
	Mon, 31 Mar 2003 20:17:42 +0100
Received: from ekner.info (0x83a4a968.virnxx10.adsl-dhcp.tele.dk [131.164.169.104])
	by pasmtp.tele.dk (Postfix) with ESMTP
	id B02D9B564; Mon, 31 Mar 2003 21:17:38 +0200 (CEST)
Message-ID: <3E889602.62B7AB6B@ekner.info>
Date: Mon, 31 Mar 2003 21:24:50 +0200
From: Hartvig Ekner <hartvig@ekner.info>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-19.7.x i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Eric DeVolder <eric.devolder@amd.com>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Re: Au1500 hardware cache coherency
References: <3E882FB8.BBFDACE2@ekner.info> <3E8853B3.9080902@amd.com>
	 <3E885B68.6927451E@ekner.info> <3E8883B8.1000000@amd.com>
Content-Type: multipart/alternative;
 boundary="------------1713AEAE854A1CE3FC3BE438"
Return-Path: <hartvig@ekner.info>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1879
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hartvig@ekner.info
Precedence: bulk
X-list: linux-mips


--------------1713AEAE854A1CE3FC3BE438
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi Eric,

I did a quick check of a complete kernel disassembly, and there are tons of direct or
indirect RMW's to config, which do not explicitly insure that Config[0D] is set.
Pete - are you aware of this? Thus, there seems to be a potential problem lurking
here for anybody who is using USB.

However, I am not using USB at all, and it is configured out of the kernel. So I assume
this is not errata #3 we're seeing here?

So, to summarize: The first set of problems in my email below seem to be fully explained
by errata #14. Note that any kernel compiled from the current CVS exhibits this problem:
Because although NONCOHEHENT_IO is set, the NC bit in PCI_CFG is not set. I have
verified that the problem occurs when NC is cleared, regardless of the .config option. So
some code needs to be changed in au1000/xxx/setup.c... (set NC if NONCOHERENT_IO
is enabled).

But - much wore worrisome: I did this modification, and with the NC bit set, and
NONCOHERENT_IO set, I get the second set of errors, although it takes much longer
time. The wback_inv calls are made through the generic code  in the subroutine
pci_alloc_consistent() (in arch/mips/kernel/pci-dma.c).

So something is wrong.... Anybody at AMD who would care to continue the debug?

/Hartvig


Eric DeVolder wrote:

> Yes, this is precisely the errata; my apologies for failing to list it explicitly earlier.
> The only other one to be aware of is that Config[OD] must be set, and the YAMON
> booter does this, but if you ever do a R-M-W of Config, then Config[OD] is reset to
> zero (this is errata #4).
>
> Also, keep in mind that you need CONFIG_NONCOHERENT_IO set so that
> the dma cache routines do a flush (and invalidate) to memory, and that these routines
> need to be called at the appropriate places in the driver.
>
> In your data dump where there are lines "missing", it sort of suggests to me that perhaps
> these memory addresses were already in the cache, and were written to memory, but
> because coherent transactions were disabled, the cache never saw them.
>
> So, in summary, for AB stepping, you need pci_config[NC]=1, Config[OD]=1, and
> CONFIG_NONCOHERENT_IO=y.
>
> Hartvig Ekner wrote:
>
>> Hi Eric,
>>
>> is that errata #12 you are referring to? (only present on silicon stepping AB?) Or are there
>> others also?
>>
>> While using HW coherency for copying large files on disk, I do get occasional data errors
>> which always look like this:
>>
>>   00061000  4c 69 6e 69 65 3a 20 20 20 20 32 34 38 33 32 0a  Linie:    24832.
>>   00061010  4c 69 6e 69 65 3a 20 20 20 20 32 34 38 33 33 0a  Linie:    24833.
>>   00061020  4c 69 6e 69 65 3a 20 20 20 20 32 34 38 33 34 0a  Linie:    24834.
>>   00061030  4c 69 6e 69 65 3a 20 20 20 20 32 34 38 33 35 0a  Linie:    24835.
>>   00061040  38 33 35 0a 4c 69 6e 69 65 3a 20 20 20 20 32 34  835.Linie:    24
>>   00061050  38 33 36 0a 4c 69 6e 69 65 3a 20 20 20 20 32 34  836.Linie:    24
>>   00061060  38 33 37 0a 38 33 37 0a 4c 69 6e 69 65 3a 20 20  837.837.Linie:
>>   00061070  4c 69 6e 69 65 3a 20 20 20 20 32 34 38 33 39 0a  Linie:    24839.
>>   00061080  38 33 39 0a 4c 69 6e 69 65 3a 20 20 20 20 32 34  839.Linie:    24
>>   00061090  38 34 30 0a 4c 69 6e 69 65 3a 20 20 20 20 32 34  840.Linie:    24
>>   000610a0  38 34 31 0a 38 34 31 0a 4c 69 6e 69 65 3a 20 20  841.841.Linie:
>>   000610b0  20 20 32 34 65 3a 20 20 20 20 32 34 38 34 33 0a    24e:    24843.
>>   000610c0  38 34 33 0a 4c 69 6e 69 65 3a 20 20 20 20 32 34  843.Linie:    24
>>   000610d0  38 34 34 0a 4c 69 6e 69 65 3a 20 20 20 20 32 34  844.Linie:    24
>>   000610e0  38 34 35 0a 38 34 35 0a 4c 69 6e 69 65 3a 20 20  845.845.Linie:
>>   000610f0  20 20 32 34 65 3a 20 20 20 20 32 34 38 34 37 0a    24e:    24847.
>>   00061100  38 34 37 0a 4c 69 6e 69 65 3a 20 20 20 20 32 34  847.Linie:    24
>>   00061110  38 34 38 0a 4c 69 6e 69 65 3a 20 20 20 20 32 34  848.Linie:    24
>>   00061120  38 34 39 0a 38 34 39 0a 4c 69 6e 69 65 3a 20 20  849.849.Linie:
>>   00061130  20 20 32 34 65 3a 20 20 20 20 32 34 38 35 31 0a    24e:    24851.
>>   00061140  4c 69 6e 69 65 3a 20 20 20 20 32 34 38 35 32 0a  Linie:    24852.
>>   00061150  4c 69 6e 69 65 3a 20 20 20 20 32 34 38 35 33 0a  Linie:    24853.
>>   00061160  4c 69 6e 69 65 3a 20 20 20 20 32 34 38 35 34 0a  Linie:    24854.
>>   00061170  4c 69 6e 69 65 3a 20 20 20 20 32 34 38 35 35 0a  Linie:    24855.
>>   00061180  4c 69 6e 69 65 3a 20 20 20 20 32 34 38 35 36 0a  Linie:    24856.
>>   00061190  4c 69 6e 69 65 3a 20 20 20 20 32 34 38 35 37 0a  Linie:    24857.
>>   000611a0  4c 69 6e 69 65 3a 20 20 20 20 32 34 38 35 38 0a  Linie:    24858.
>>   000611b0  4c 69 6e 69 65 3a 20 20 20 20 32 34 38 35 39 0a  Linie:    24859.
>>   000611c0  4c 69 6e 69 65 3a 20 20 20 20 32 34 38 36 30 0a  Linie:    24860.
>>
>> The file consists of 16-byte lines with increasing line numbers. Note that most of
>> the errors are cacheline oriented,  but there are also "skews" of 4 bytes going
>> into the next cacheline.
>>
>> However, interestingly enough, switching HW coherency off entirely
>> (in PCI_CFG) and using uncached PCI buffers, there are still failures:
>>
>>   001ec060  4c 69 6e 69 65 3a 20 20 20 31 32 35 39 35 38 0a  Linie:   125958.
>>   001ec070  4c 69 6e 69 65 3a 20 20 20 31 32 35 39 35 39 0a  Linie:   125959.
>>   001ec080  4c 69 6e 69 65 3a 20 20 20 31 32 35 39 36 30 0a  Linie:   125960.
>>   001ec090  4c 69 6e 69 65 3a 20 20 20 31 32 35 39 36 31 0a  Linie:   125961.
>>   001ec0a0  00 00 00 00 00 00 00 00 03 00 09 00 00 00 00 00  ................
>>   001ec0b0  00 00 00 00 00 00 00 00 03 00 0a 00 00 00 00 00  ................
>>   001ec0c0  4c 69 6e 69 65 3a 20 20 20 31 32 35 39 36 34 0a  Linie:   125964.
>>   001ec0d0  4c 69 6e 69 65 3a 20 20 20 31 32 35 39 36 35 0a  Linie:   125965.
>>   001ec0e0  4c 69 6e 69 65 3a 20 20 20 31 32 35 39 36 36 0a  Linie:   125966.
>>   001ec0f0  4c 69 6e 69 65 3a 20 20 20 31 32 35 39 36 37 0a  Linie:   125967.
>>   001ec100  00 00 00 00 00 00 00 00 10 00 00 00 c7 00 00 00  ................
>>   001ec110  00 00 00 00 00 00 00 00 10 00 00 00 dd 00 00 00  ................
>>   001ec120  4c 69 6e 69 65 3a 20 20 20 31 32 35 39 37 30 0a  Linie:   125970.
>>   001ec130  4c 69 6e 69 65 3a 20 20 20 31 32 35 39 37 31 0a  Linie:   125971.
>>   001ec140  4c 69 6e 69 65 3a 20 20 20 31 32 35 39 37 32 0a  Linie:   125972.
>>   001ec150  4c 69 6e 69 65 3a 20 20 20 31 32 35 39 37 33 0a  Linie:   125973.
>>   001ec160  4c 69 6e 69 65 3a 20 20 20 31 32 35 39 37 34 0a  Linie:   125974.
>>
>> Is there anything else than bit 16 in the PCI_CFG register which needs to be set
>> to force non-coherent PCI accesses and avoid the PCI errata?
>>
>> /Hartvig
>>
>>
>>
>>

--------------1713AEAE854A1CE3FC3BE438
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
Hi Eric,
<p>I&nbsp;did a quick check of a complete kernel disassembly, and there
are tons of direct or
<br>indirect RMW's to config, which do not explicitly insure that Config[0D]
is set.
<br>Pete - are you aware of this? Thus, there seems to be a potential problem
lurking
<br>here for anybody who is using USB.
<p>However, I&nbsp;am not using USB&nbsp;at all, and it is configured out
of the kernel. So I&nbsp;assume
<br>this is not errata #3 we're seeing here?
<p>So, to summarize:&nbsp;The first set of problems in my email below seem
to be fully explained
<br>by errata #14. Note that any kernel compiled from the current CVS exhibits
this problem:
<br>Because although NONCOHEHENT_IO&nbsp;is set, the NC&nbsp;bit in PCI_CFG&nbsp;is
not set. I&nbsp;have
<br>verified that the problem occurs when NC is cleared, regardless of
the .config option. So
<br>some code needs to be changed in au1000/xxx/setup.c... (set NC&nbsp;if
NONCOHERENT_IO
<br>is enabled).
<p>But - much wore worrisome:&nbsp;I&nbsp;did this modification, and with
the NC&nbsp;bit set, and
<br>NONCOHERENT_IO&nbsp;set, I&nbsp;get the second set of errors, although
it takes much longer
<br>time. The wback_inv calls are made through the generic code&nbsp; in
the subroutine
<br>pci_alloc_consistent() (in arch/mips/kernel/pci-dma.c).
<p>So something is wrong.... Anybody at AMD&nbsp;who would care to continue
the debug?
<p>/Hartvig
<br>&nbsp;
<p>Eric DeVolder wrote:
<blockquote TYPE=CITE>Yes, this is precisely the errata; my apologies for
failing to list it explicitly earlier.
<br>The only other one to be aware of is that Config[OD] must be set, and
the YAMON
<br>booter does this, but if you ever do a R-M-W of Config, then Config[OD]
is reset to
<br>zero (this is errata #4).
<p>Also, keep in mind that you need CONFIG_NONCOHERENT_IO set so that
<br>the dma cache routines do a flush (and invalidate) to memory, and that
these routines
<br>need to be called at the appropriate places in the driver.
<p>In your data dump where there are lines "missing", it sort of suggests
to me that perhaps
<br>these memory addresses were already in the cache, and were written
to memory, but
<br>because coherent transactions were disabled, the cache never saw them.
<p>So, in summary, for AB stepping, you need pci_config[NC]=1, Config[OD]=1,
and
<br>CONFIG_NONCOHERENT_IO=y.
<p>Hartvig Ekner wrote:
<blockquote type="cite" cite="mid3E885B68.6927451E@ekner.info">
<div wrap="">Hi Eric,<br>
<br>
is that errata #12 you are referring to? (only present on silicon stepping
AB?) Or are there<br>
others also?<br>
<br>
While using HW coherency for copying large files on disk, I do get occasional
data errors<br>
which always look like this:<br>
<br>
&nbsp; 00061000&nbsp; 4c 69 6e 69 65 3a 20 20 20 20 32 34 38 33 32 0a&nbsp;
Linie:&nbsp;&nbsp;&nbsp; 24832.<br>
&nbsp; 00061010&nbsp; 4c 69 6e 69 65 3a 20 20 20 20 32 34 38 33 33 0a&nbsp;
Linie:&nbsp;&nbsp;&nbsp; 24833.<br>
&nbsp; 00061020&nbsp; 4c 69 6e 69 65 3a 20 20 20 20 32 34 38 33 34 0a&nbsp;
Linie:&nbsp;&nbsp;&nbsp; 24834.<br>
&nbsp; 00061030&nbsp; 4c 69 6e 69 65 3a 20 20 20 20 32 34 38 33 35 0a&nbsp;
Linie:&nbsp;&nbsp;&nbsp; 24835.<br>
&nbsp; 00061040&nbsp; 38 33 35 0a 4c 69 6e 69 65 3a 20 20 20 20 32 34&nbsp;
835.Linie:&nbsp;&nbsp;&nbsp; 24<br>
&nbsp; 00061050&nbsp; 38 33 36 0a 4c 69 6e 69 65 3a 20 20 20 20 32 34&nbsp;
836.Linie:&nbsp;&nbsp;&nbsp; 24<br>
&nbsp; 00061060&nbsp; 38 33 37 0a 38 33 37 0a 4c 69 6e 69 65 3a 20 20&nbsp;
837.837.Linie:<br>
&nbsp; 00061070&nbsp; 4c 69 6e 69 65 3a 20 20 20 20 32 34 38 33 39 0a&nbsp;
Linie:&nbsp;&nbsp;&nbsp; 24839.<br>
&nbsp; 00061080&nbsp; 38 33 39 0a 4c 69 6e 69 65 3a 20 20 20 20 32 34&nbsp;
839.Linie:&nbsp;&nbsp;&nbsp; 24<br>
&nbsp; 00061090&nbsp; 38 34 30 0a 4c 69 6e 69 65 3a 20 20 20 20 32 34&nbsp;
840.Linie:&nbsp;&nbsp;&nbsp; 24<br>
&nbsp; 000610a0&nbsp; 38 34 31 0a 38 34 31 0a 4c 69 6e 69 65 3a 20 20&nbsp;
841.841.Linie:<br>
&nbsp; 000610b0&nbsp; 20 20 32 34 65 3a 20 20 20 20 32 34 38 34 33 0a&nbsp;&nbsp;&nbsp;
24e:&nbsp;&nbsp;&nbsp; 24843.<br>
&nbsp; 000610c0&nbsp; 38 34 33 0a 4c 69 6e 69 65 3a 20 20 20 20 32 34&nbsp;
843.Linie:&nbsp;&nbsp;&nbsp; 24<br>
&nbsp; 000610d0&nbsp; 38 34 34 0a 4c 69 6e 69 65 3a 20 20 20 20 32 34&nbsp;
844.Linie:&nbsp;&nbsp;&nbsp; 24<br>
&nbsp; 000610e0&nbsp; 38 34 35 0a 38 34 35 0a 4c 69 6e 69 65 3a 20 20&nbsp;
845.845.Linie:<br>
&nbsp; 000610f0&nbsp; 20 20 32 34 65 3a 20 20 20 20 32 34 38 34 37 0a&nbsp;&nbsp;&nbsp;
24e:&nbsp;&nbsp;&nbsp; 24847.<br>
&nbsp; 00061100&nbsp; 38 34 37 0a 4c 69 6e 69 65 3a 20 20 20 20 32 34&nbsp;
847.Linie:&nbsp;&nbsp;&nbsp; 24<br>
&nbsp; 00061110&nbsp; 38 34 38 0a 4c 69 6e 69 65 3a 20 20 20 20 32 34&nbsp;
848.Linie:&nbsp;&nbsp;&nbsp; 24<br>
&nbsp; 00061120&nbsp; 38 34 39 0a 38 34 39 0a 4c 69 6e 69 65 3a 20 20&nbsp;
849.849.Linie:<br>
&nbsp; 00061130&nbsp; 20 20 32 34 65 3a 20 20 20 20 32 34 38 35 31 0a&nbsp;&nbsp;&nbsp;
24e:&nbsp;&nbsp;&nbsp; 24851.<br>
&nbsp; 00061140&nbsp; 4c 69 6e 69 65 3a 20 20 20 20 32 34 38 35 32 0a&nbsp;
Linie:&nbsp;&nbsp;&nbsp; 24852.<br>
&nbsp; 00061150&nbsp; 4c 69 6e 69 65 3a 20 20 20 20 32 34 38 35 33 0a&nbsp;
Linie:&nbsp;&nbsp;&nbsp; 24853.<br>
&nbsp; 00061160&nbsp; 4c 69 6e 69 65 3a 20 20 20 20 32 34 38 35 34 0a&nbsp;
Linie:&nbsp;&nbsp;&nbsp; 24854.<br>
&nbsp; 00061170&nbsp; 4c 69 6e 69 65 3a 20 20 20 20 32 34 38 35 35 0a&nbsp;
Linie:&nbsp;&nbsp;&nbsp; 24855.<br>
&nbsp; 00061180&nbsp; 4c 69 6e 69 65 3a 20 20 20 20 32 34 38 35 36 0a&nbsp;
Linie:&nbsp;&nbsp;&nbsp; 24856.<br>
&nbsp; 00061190&nbsp; 4c 69 6e 69 65 3a 20 20 20 20 32 34 38 35 37 0a&nbsp;
Linie:&nbsp;&nbsp;&nbsp; 24857.<br>
&nbsp; 000611a0&nbsp; 4c 69 6e 69 65 3a 20 20 20 20 32 34 38 35 38 0a&nbsp;
Linie:&nbsp;&nbsp;&nbsp; 24858.<br>
&nbsp; 000611b0&nbsp; 4c 69 6e 69 65 3a 20 20 20 20 32 34 38 35 39 0a&nbsp;
Linie:&nbsp;&nbsp;&nbsp; 24859.<br>
&nbsp; 000611c0&nbsp; 4c 69 6e 69 65 3a 20 20 20 20 32 34 38 36 30 0a&nbsp;
Linie:&nbsp;&nbsp;&nbsp; 24860.<br>
<br>
The file consists of 16-byte lines with increasing line numbers. Note that
most of<br>
the errors are cacheline oriented,&nbsp; but there are also "skews" of
4 bytes going<br>
into the next cacheline.<br>
<br>
However, interestingly enough, switching HW coherency off entirely<br>
(in PCI_CFG) and using uncached PCI buffers, there are still failures:<br>
<br>
&nbsp; 001ec060&nbsp; 4c 69 6e 69 65 3a 20 20 20 31 32 35 39 35 38 0a&nbsp;
Linie:&nbsp;&nbsp; 125958.<br>
&nbsp; 001ec070&nbsp; 4c 69 6e 69 65 3a 20 20 20 31 32 35 39 35 39 0a&nbsp;
Linie:&nbsp;&nbsp; 125959.<br>
&nbsp; 001ec080&nbsp; 4c 69 6e 69 65 3a 20 20 20 31 32 35 39 36 30 0a&nbsp;
Linie:&nbsp;&nbsp; 125960.<br>
&nbsp; 001ec090&nbsp; 4c 69 6e 69 65 3a 20 20 20 31 32 35 39 36 31 0a&nbsp;
Linie:&nbsp;&nbsp; 125961.<br>
&nbsp; 001ec0a0&nbsp; 00 00 00 00 00 00 00 00 03 00 09 00 00 00 00 00&nbsp;
................<br>
&nbsp; 001ec0b0&nbsp; 00 00 00 00 00 00 00 00 03 00 0a 00 00 00 00 00&nbsp;
................<br>
&nbsp; 001ec0c0&nbsp; 4c 69 6e 69 65 3a 20 20 20 31 32 35 39 36 34 0a&nbsp;
Linie:&nbsp;&nbsp; 125964.<br>
&nbsp; 001ec0d0&nbsp; 4c 69 6e 69 65 3a 20 20 20 31 32 35 39 36 35 0a&nbsp;
Linie:&nbsp;&nbsp; 125965.<br>
&nbsp; 001ec0e0&nbsp; 4c 69 6e 69 65 3a 20 20 20 31 32 35 39 36 36 0a&nbsp;
Linie:&nbsp;&nbsp; 125966.<br>
&nbsp; 001ec0f0&nbsp; 4c 69 6e 69 65 3a 20 20 20 31 32 35 39 36 37 0a&nbsp;
Linie:&nbsp;&nbsp; 125967.<br>
&nbsp; 001ec100&nbsp; 00 00 00 00 00 00 00 00 10 00 00 00 c7 00 00 00&nbsp;
................<br>
&nbsp; 001ec110&nbsp; 00 00 00 00 00 00 00 00 10 00 00 00 dd 00 00 00&nbsp;
................<br>
&nbsp; 001ec120&nbsp; 4c 69 6e 69 65 3a 20 20 20 31 32 35 39 37 30 0a&nbsp;
Linie:&nbsp;&nbsp; 125970.<br>
&nbsp; 001ec130&nbsp; 4c 69 6e 69 65 3a 20 20 20 31 32 35 39 37 31 0a&nbsp;
Linie:&nbsp;&nbsp; 125971.<br>
&nbsp; 001ec140&nbsp; 4c 69 6e 69 65 3a 20 20 20 31 32 35 39 37 32 0a&nbsp;
Linie:&nbsp;&nbsp; 125972.<br>
&nbsp; 001ec150&nbsp; 4c 69 6e 69 65 3a 20 20 20 31 32 35 39 37 33 0a&nbsp;
Linie:&nbsp;&nbsp; 125973.<br>
&nbsp; 001ec160&nbsp; 4c 69 6e 69 65 3a 20 20 20 31 32 35 39 37 34 0a&nbsp;
Linie:&nbsp;&nbsp; 125974.<br>
<br>
Is there anything else than bit 16 in the PCI_CFG register which needs
to be set<br>
to force non-coherent PCI accesses and avoid the PCI errata?<br>
<br>
/Hartvig<br>
<br>
<br>
<br>
<BR></div>
</blockquote>
</blockquote>
</html>

--------------1713AEAE854A1CE3FC3BE438--
