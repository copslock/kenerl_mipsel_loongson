Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jun 2013 18:43:22 +0200 (CEST)
Received: from kymasys.com ([64.62.140.43]:34337 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6835104Ab3FJQnPQpfQg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Jun 2013 18:43:15 +0200
Received: from ::ffff:75.40.23.192 ([75.40.23.192]) by kymasys.com for <linux-mips@linux-mips.org>; Mon, 10 Jun 2013 09:43:06 -0700
Subject: Re: [PATCH 00/31] KVM/MIPS: Implement hardware virtualization via the MIPS-VZ extensions.
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From:   Sanjay Lal <sanjayl@kymasys.com>
In-Reply-To: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
Date:   Mon, 10 Jun 2013 09:43:12 -0700
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <8D7771A4-B51E-4FA8-9342-621FE41792DE@kymasys.com>
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
To:     David Daney <ddaney.cavm@gmail.com>
X-Mailer: Apple Mail (2.1283)
Return-Path: <sanjayl@kymasys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36810
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sanjayl@kymasys.com
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


On Jun 7, 2013, at 4:03 PM, David Daney wrote:

> From: David Daney <david.daney@cavium.com>
> 
> These patches take a somewhat different approach to MIPS
> virtualization via the MIPS-VZ extensions than the patches previously
> sent by Sanjay Lal.
> 
> Several facts about the code:
> 
> 
> o Currently probably only usable on the OCTEON III CPU model, as some
>  MIPS-VZ implementation-defined behaviors were assumed to have the
>  OCTEON III behavior.
> 


I've only briefly gone over the patches, but I was wondering if the Cavium implementation has support for GuestIDs, which are optional in the VZ-ASE?

Regards
Sanjay
