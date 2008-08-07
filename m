Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Aug 2008 10:12:49 +0100 (BST)
Received: from mx0.towertech.it ([213.215.222.73]:46744 "HELO mx0.towertech.it")
	by ftp.linux-mips.org with SMTP id S20024994AbYHGJMl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 7 Aug 2008 10:12:41 +0100
Received: (qmail 8690 invoked from network); 7 Aug 2008 11:12:39 +0200
Received: from unknown (HELO i1501.lan.towertech.it) (81.208.60.204)
  by mx0.towertech.it with SMTP; 7 Aug 2008 11:12:39 +0200
Date:	Thu, 7 Aug 2008 11:12:38 +0200
From:	Alessandro Zummo <alessandro.zummo@towertech.it>
To:	Geert Uytterhoeven <geert@linux-m68k.org>
Cc:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	rtc-linux@googlegroups.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] DS1286: new RTC driver
Message-ID: <20080807111238.69e7e46e@i1501.lan.towertech.it>
In-Reply-To: <Pine.LNX.4.64.0808071102420.23641@anakin>
References: <20080803174137.AF8071DA6F4@solo.franken.de>
	<20080807105249.50d6e777@i1501.lan.towertech.it>
	<Pine.LNX.4.64.0808071102420.23641@anakin>
Organization: Tower Technologies
X-Mailer: Sylpheed
X-This-Is-A-Real-Message: Yes
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <alessandro.zummo@towertech.it>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20147
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alessandro.zummo@towertech.it
Precedence: bulk
X-list: linux-mips

On Thu, 7 Aug 2008 11:03:07 +0200 (CEST)
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> >  sizeof(struct ds1286_priv) is a little bit cleaner.  
> 
> What if the type of priv changes?

 It shouldn't in such a small context . however, it is not required,
 is just my personal preference about readability.

 parentheses around the sizeof are, ont he other side, required.

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
