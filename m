Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Jun 2009 23:36:07 +0200 (CEST)
Received: from web23606.mail.ird.yahoo.com ([87.248.115.49]:38662 "HELO
	web23606.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with SMTP id S1492724AbZFOVgB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 15 Jun 2009 23:36:01 +0200
Received: (qmail 37312 invoked by uid 60001); 15 Jun 2009 21:34:57 -0000
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.co.uk; s=s1024; t=1245101697; bh=sBeAL6SOj1vhW4UcbOM5ggHmKlPJWpahel2mbl2/18A=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding; b=zzhRwQ8920Ir00z0T80x14H6PDVN74rMmQOgFDutQYvtJPfcx0JZwf1cX2D+30YtRT3D/yA2q+yrV89T/VSopaIRr/EyduSroGondn3fQe2zvR3XyoIWjSXenzrWGru1GRr68s2XO3zac9Qymi6bX2cN2J3MDbbKQSalKVentdk=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.uk;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Z3v+hc4G8OWSTtKNfAEvq0QVTfKu6oRAc/3h0tdpdr63WzzqurE+GlmrD4t3yHPfUxuibcFRnQ+8VgQA00oP+OeeflUgSpNhV0iKKZnIZKx3tQn5Rko0qLCLqI3belE/lwsqzGLVAD6koiFnnc2RW4gJOsGfAGzUZFTBJCo3PKg=;
Message-ID: <818181.15589.qm@web23606.mail.ird.yahoo.com>
X-YMail-OSG: _BdlTlIVM1kQ2fdCNynP7ATlgecCBg6hpd9klPqTmC_w8_2sKKmqOrUSuEwQEl0945_MBwV3FfMdzcNanPLEcviRkGMzqah43H_L0G_JxMkqC5bYyoWyhGlNysAXWLgLTLQpmlBwRDmNJQW71vczhRZGUPBh_qVFb.v8hTRVoJTE7ajB5AzhT5QAF5Fn7YPnQ5ruKGne.n12auCHq6ksfbSe3LzArbBwd25iq5DoO8w35tbcA2KR_WPcLXW2TmfqxQ1lNihx0yiyDfIS7jM.rO8ybSE8cWM1Wm_89tq1kRD3M1RLmm.sM4MorLN5QWgws9_b01v6XPF._.RSWpdSmIOc2Dz8e.EQe8oUgBWlDZ8MvFpZe__J78KExLzVlA--
Received: from [87.113.23.116] by web23606.mail.ird.yahoo.com via HTTP; Mon, 15 Jun 2009 21:34:57 GMT
X-Mailer: YahooMailClassic/5.4.12 YahooMailWebService/0.7.289.15
Date:	Mon, 15 Jun 2009 21:34:57 +0000 (GMT)
From:	Glyn Astill <glynastill@yahoo.co.uk>
Subject: Re: Qube2 slowly dies
To:	"Kevin D. Kissell" <kevink@paralogos.com>
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <glynastill@yahoo.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23426
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: glynastill@yahoo.co.uk
Precedence: bulk
X-list: linux-mips




--- On Fri, 12/6/09, Kevin D. Kissell <kevink@paralogos.com> wrote:
>   
>     Your description sounds an awful lot
> like failures I've seen when 
> interrupts get lost or blocked for some reason (could be
> hardware, the 
> kernel, or some interaction between them).  Have you
> looked at 
>  to see if "Spurious" interrupts are
> occurring, or if 
> the rate of serviced timer and I/O interrupts decreases or
> increases as 
> the system degrades?
>     
>   
>   
> No I haven't checked - but I will. What would I be
> looking for that would stick out as "spurious"?
> The type of interrupt, qty or random interrupts appearing
> and dissapearing?
>   
> 
> There's a separate counter, and /proc/interrupts
> report, for spurious
> interrupts.
> 
>

I've just tested it and I see no extra counters appearing, unless the cascade is an issue

deb:~#  cat /proc/interrupts
           CPU0
  0:          1          XT-PIC  timer
  2:          0          XT-PIC  cascade
  8:          2          XT-PIC  rtc0
  9:          0          XT-PIC  ohci_hcd:usb1, ehci_hcd:usb2, ohci_hcd:usb3
 14:       3166          XT-PIC  ide0
 15:          0          XT-PIC  ide1
 18:          0            MIPS  cascade
 19:       4399            MIPS  eth0
 21:        361            MIPS  serial
 22:          0            MIPS  cascade
 23:     274025            MIPS  timer
 32:          2         GT641xx  gt641xx_timer0


When the machine starts to go, the cpu time column in top sometimes shows nan - surely that shouldn't happen -it should be either 0 or >0 
 
Any other ides chaps?


      
