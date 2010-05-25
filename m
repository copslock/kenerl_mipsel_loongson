Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 May 2010 15:48:26 +0200 (CEST)
Received: from imr3.ericy.com ([198.24.6.13]:60658 "EHLO imr3.ericy.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491904Ab0EYNsV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 25 May 2010 15:48:21 +0200
Received: from eusaamw0707.eamcs.ericsson.se ([147.117.20.32])
        by imr3.ericy.com (8.13.8/8.13.8) with ESMTP id o4PDm1WT000625
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 25 May 2010 08:48:07 -0500
Received: from localhost (147.117.20.212) by eusaamw0707.eamcs.ericsson.se
 (147.117.20.92) with Microsoft SMTP Server id 8.2.234.1; Tue, 25 May 2010
 09:48:01 -0400
Date:   Tue, 25 May 2010 06:48:01 -0700
From:   Guenter Roeck <guenter.roeck@ericsson.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Dmitri Vorobiev <dmitri.vorobiev@gmail.com>,
        octane indice <octane@alinto.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Cross compiling MIPS kernel under x86
Message-ID: <20100525134801.GA26977@ericsson.com>
References: <1274711094.4bfa8c3675983@www.inmano.com>
 <AANLkTinOaPkOXm128trTQ39jNGWMcvPhVUGWSQz6hLjR@mail.gmail.com>
 <20100525131341.GA26500@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20100525131341.GA26500@linux-mips.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <groeck@ericsson.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26849
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guenter.roeck@ericsson.com
Precedence: bulk
X-list: linux-mips

On Tue, May 25, 2010 at 09:13:41AM -0400, Ralf Baechle wrote:
> On Mon, May 24, 2010 at 05:33:01PM +0300, Dmitri Vorobiev wrote:
> 
> > It looks like your toolchain is quite old. I just tried building a
> > Cavium Octeon defconfig using my custom toolchain based on GCC 4.3.1
> > and binutils 2.19.51.20090304, and the build was successfull. Before
> > you ask: yes, GCC did receive `-march=octeon' :)
> 
> Tools requirements to build a kernel have become a little bit confusing.
> I'm sure there are more restrictions that I've forgot.
> 
>  * The Lemote 2F defconfig requires binutils 2.20 to build.
>  * GCC 3.2 is a lost cause for building 64-bit kernels
>  * GCC 3.3 is broken but can just about be kludged to build a 64-bit kernel.
>  * GCC 4.4 or a patched older version is required to build a kernel O2 or
>    Indigo² with R10000 processors.
>  * GCC 3.2 used to work for the rest but it's a very long time since I
>    tested this for a modern kernel.
>  * Linux 2.6.29 and older need a GCC older than 4.4.0 to compile. 
> 
The toolchain from emdebian seems to work fine for me, though it is at times
a bit difficult to set up due to bad dependencies.

Guenter
