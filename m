Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Nov 2012 06:59:12 +0100 (CET)
Received: from co9ehsobe001.messaging.microsoft.com ([207.46.163.24]:7422 "EHLO
        co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817528Ab2KBF7LGVGWN convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 2 Nov 2012 06:59:11 +0100
Received: from mail114-co9-R.bigfish.com (10.236.132.253) by
 CO9EHSOBE018.bigfish.com (10.236.130.81) with Microsoft SMTP Server id
 14.1.225.23; Fri, 2 Nov 2012 05:59:02 +0000
Received: from mail114-co9 (localhost [127.0.0.1])      by
 mail114-co9-R.bigfish.com (Postfix) with ESMTP id 7BDED240160; Fri,  2 Nov
 2012 05:59:02 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:70.37.183.190;KIP:(null);UIP:(null);IPV:NLI;H:mail.freescale.net;RD:none;EFVD:NLI
X-SpamScore: -8
X-BigFish: VS-8(zzbb2dI98dI9371I542M1432Izz1de0h1202h1d1ah1d2ahzz8275dhz2dh2a8h668h839h8e2h8e3h944hd25hf0ah1220h1288h12a5h12a9h12bdh137ah13b6h1441h1504h1537h153bhbe9i1155h)
Received: from mail114-co9 (localhost.localdomain [127.0.0.1]) by mail114-co9
 (MessageSwitch) id 135183594135390_10338; Fri,  2 Nov 2012 05:59:01 +0000
 (UTC)
Received: from CO9EHSMHS011.bigfish.com (unknown [10.236.132.229])      by
 mail114-co9.bigfish.com (Postfix) with ESMTP id 064C0200047;   Fri,  2 Nov 2012
 05:59:01 +0000 (UTC)
Received: from mail.freescale.net (70.37.183.190) by CO9EHSMHS011.bigfish.com
 (10.236.130.21) with Microsoft SMTP Server (TLS) id 14.1.225.23; Fri, 2 Nov
 2012 05:59:01 +0000
Received: from 039-SN2MPN1-013.039d.mgd.msft.net ([169.254.3.250]) by
 039-SN1MMR1-001.039d.mgd.msft.net ([10.84.1.13]) with mapi id 14.02.0318.003;
 Fri, 2 Nov 2012 05:59:00 +0000
From:   Sethi Varun-B16395 <B16395@freescale.com>
To:     Sanjay Lal <sanjayl@kymasys.com>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Avi Kivity <avi@redhat.com>
Subject: RE: [PATCH 07/20] KVM/MIPS32: Dynamic binary translation of select
  privileged instructions.
Thread-Topic: [PATCH 07/20] KVM/MIPS32: Dynamic binary translation of select
  privileged instructions.
Thread-Index: AQHNuEVulN6OT9I95U21bJP1Lp8VEpfWDJDA
Date:   Fri, 2 Nov 2012 05:58:59 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D25469A@039-SN2MPN1-013.039d.mgd.msft.net>
References: <3E678B37-B4C1-409F-A1CB-A7CC83B2D874@kymasys.com>
 <5092942C.4080402@redhat.com>
In-Reply-To: <5092942C.4080402@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.132.1]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: freescale.com
X-archive-position: 34850
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: B16395@freescale.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>



> -----Original Message-----
> From: kvm-owner@vger.kernel.org [mailto:kvm-owner@vger.kernel.org] On
> Behalf Of Avi Kivity
> Sent: Thursday, November 01, 2012 8:54 PM
> To: Sanjay Lal
> Cc: kvm@vger.kernel.org; linux-mips@linux-mips.org
> Subject: Re: [PATCH 07/20] KVM/MIPS32: Dynamic binary translation of
> select privileged instructions.
> 
> On 10/31/2012 05:19 PM, Sanjay Lal wrote:
> > Currently, the following instructions are translated:
> > - CACHE (indexed)
> > - CACHE (va based): translated to a synci, overkill on D-CACHE
> operations, but still much faster than a trap.
> > - mfc0/mtc0: the virtual COP0 registers for the guest are implemented
> as 2-D array
> >   [COP#][SEL] and this is mapped into the guest kernel address space @
> VA 0x0.
> >   mfc0/mtc0 operations are transformed to load/stores.
> >
> 
> Seems to be more of binary patching, yes?  Binary translation usually
> involves hiding the translated code so the guest is not able to detect
> that it is patched.
> 
Typically, a dynamic binary translation solution should also involve a mechanism to trace the guest access to the modified pages. I don't think that support is present as a part
of the patch set. Do you plan to implement it?

-Varun
