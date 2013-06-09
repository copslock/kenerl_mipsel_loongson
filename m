Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jun 2013 01:40:43 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:41998 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835055Ab3FIXkmkNmBo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Jun 2013 01:40:42 +0200
Date:   Mon, 10 Jun 2013 00:40:42 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     David Daney <david.s.daney@gmail.com>
cc:     Gleb Natapov <gleb@redhat.com>,
        David Daney <ddaney@caviumnetworks.com>,
        David Daney <ddaney.cavm@gmail.com>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Sanjay Lal <sanjayl@kymasys.com>, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 00/31] KVM/MIPS: Implement hardware virtualization via
 the MIPS-VZ extensions.
In-Reply-To: <51B50E87.2060501@gmail.com>
Message-ID: <alpine.LFD.2.03.1306100030210.18329@linux-mips.org>
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com> <51B26974.5000306@caviumnetworks.com> <20130609073115.GE4725@redhat.com> <51B50E87.2060501@gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36761
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Sun, 9 Jun 2013, David Daney wrote:

> >   How different MIPS SMP systems are?
> 
> o Old SGI heavy metal (several different system architectures).
> 
> o Cavium OCTEON SMP SoCs.
> 
> o Broadcom (several flavors) SoCs
> 
> o Loongson

o Old DEC hardware (DECsystem 58x0, R3000-based).

o Malta-based MIPS Technologies CMP solutions (1004K, 1074K, interAptiv).

  Maciej
