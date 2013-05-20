Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 May 2013 20:36:24 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:53996 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823019Ab3ETSgXqB6yN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 May 2013 20:36:23 +0200
Date:   Mon, 20 May 2013 19:36:23 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Sanjay Lal <sanjayl@kymasys.com>
cc:     David Daney <ddaney.cavm@gmail.com>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 00/18] KVM/MIPS32: Support for the new Virtualization
 ASE (VZ-ASE)
In-Reply-To: <456B70C6-A896-4B94-B8EF-DE6ED26CE859@kymasys.com>
Message-ID: <alpine.LFD.2.03.1305201930570.10753@linux-mips.org>
References: <n> <1368942460-15577-1-git-send-email-sanjayl@kymasys.com> <519A4640.6060202@gmail.com> <456B70C6-A896-4B94-B8EF-DE6ED26CE859@kymasys.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36487
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

On Mon, 20 May 2013, Sanjay Lal wrote:

> (1) Newer versions of the MIPS architecture define scratch registers for 
> just this purpose, but since we have to support standard MIPS32R2 
> processors, we use the DDataLo Register (CP0 Register 28, Select 3) as a 
> scratch register to save k0 and save k1 @ a known offset from EBASE.

 That's rather risky as the implementation of this register (and its 
presence in the first place) is processor-specific.  Do you maintain a 
list of PRId values the use of this register is safe with?

  Maciej
