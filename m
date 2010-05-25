Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 May 2010 15:13:54 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:41094 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491850Ab0EYNNt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 25 May 2010 15:13:49 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o4PDDh3r003394;
        Tue, 25 May 2010 14:13:44 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o4PDDgfX003392;
        Tue, 25 May 2010 14:13:42 +0100
Date:   Tue, 25 May 2010 14:13:41 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
Cc:     octane indice <octane@alinto.com>, linux-mips@linux-mips.org
Subject: Re: Cross compiling MIPS kernel under x86
Message-ID: <20100525131341.GA26500@linux-mips.org>
References: <1274711094.4bfa8c3675983@www.inmano.com>
 <AANLkTinOaPkOXm128trTQ39jNGWMcvPhVUGWSQz6hLjR@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AANLkTinOaPkOXm128trTQ39jNGWMcvPhVUGWSQz6hLjR@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26848
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, May 24, 2010 at 05:33:01PM +0300, Dmitri Vorobiev wrote:

> It looks like your toolchain is quite old. I just tried building a
> Cavium Octeon defconfig using my custom toolchain based on GCC 4.3.1
> and binutils 2.19.51.20090304, and the build was successfull. Before
> you ask: yes, GCC did receive `-march=octeon' :)

Tools requirements to build a kernel have become a little bit confusing.
I'm sure there are more restrictions that I've forgot.

 * The Lemote 2F defconfig requires binutils 2.20 to build.
 * GCC 3.2 is a lost cause for building 64-bit kernels
 * GCC 3.3 is broken but can just about be kludged to build a 64-bit kernel.
 * GCC 4.4 or a patched older version is required to build a kernel O2 or
   Indigo² with R10000 processors.
 * GCC 3.2 used to work for the rest but it's a very long time since I
   tested this for a modern kernel.
 * Linux 2.6.29 and older need a GCC older than 4.4.0 to compile. 

  Ralf
