Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2015 19:27:59 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:52246 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006717AbbJMR15IEgnY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Oct 2015 19:27:57 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1Zm3Mb-00020k-1F; Tue, 13 Oct 2015 19:27:49 +0200
Date:   Tue, 13 Oct 2015 19:27:12 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
cc:     Qais Yousef <qais.yousef@imgtec.com>, linux-kernel@vger.kernel.org,
        jason@lakedaemon.net, marc.zyngier@arm.com,
        jiang.liu@linux.intel.com, ralf@linux-mips.org,
        linux-mips@linux-mips.org
Subject: Re: [RFC v2 PATCH 00/14] Implement generic IPI support mechanism
In-Reply-To: <561D3E4C.909@cogentembedded.com>
Message-ID: <alpine.DEB.2.11.1510131926410.25029@nanos>
References: <1444731382-19313-1-git-send-email-qais.yousef@imgtec.com> <alpine.DEB.2.11.1510131550020.25029@nanos> <561D3E4C.909@cogentembedded.com>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49533
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
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

On Tue, 13 Oct 2015, Sergei Shtylyov wrote:
> On 10/13/2015 04:53 PM, Thomas Gleixner wrote:
> > 
> > Please base it on 4.1-rc5 + irq/core.
> 
>    On 4.3-rc5, you mean?

Indeed!
