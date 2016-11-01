Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Nov 2016 20:05:10 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:54785 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993215AbcKATFD6cJ1a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Nov 2016 20:05:03 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 5321B3D8E07E6;
        Tue,  1 Nov 2016 19:04:53 +0000 (GMT)
Received: from [10.20.78.238] (10.20.78.238) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Tue, 1 Nov 2016
 19:04:56 +0000
Date:   Tue, 1 Nov 2016 19:04:48 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Markus Gothe <nietzsche@lysator.liu.se>
CC:     Deepak Gaur <dgaur@cdot.in>, <linux-mips@linux-mips.org>
Subject: Re: System clock going slow/fast with ntpdate
In-Reply-To: <012925E3-E06F-413D-BBD4-9BF40F0F08A7@lysator.liu.se>
Message-ID: <alpine.DEB.2.00.1611011900260.24498@tp.orcam.me.uk>
References: <20161026081208.M10605@cdot.in> <20161026085306.M18729@cdot.in> <012925E3-E06F-413D-BBD4-9BF40F0F08A7@lysator.liu.se>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.238]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55642
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

On Tue, 1 Nov 2016, Markus Gothe wrote:

> You should calculate your boards time drift and compensate for it.

 Well it can't help if the clock rate changes spontaneously, can it?

  Maciej
