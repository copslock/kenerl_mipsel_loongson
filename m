Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Apr 2016 19:19:04 +0200 (CEST)
Received: from e06smtp07.uk.ibm.com ([195.75.94.103]:41911 "EHLO
        e06smtp07.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026632AbcDURTDKKMFP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Apr 2016 19:19:03 +0200
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <gkurz@linux.vnet.ibm.com>;
        Thu, 21 Apr 2016 18:18:57 +0100
Received: from d06dlp02.portsmouth.uk.ibm.com (9.149.20.14)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Thu, 21 Apr 2016 18:18:56 +0100
X-IBM-Helo: d06dlp02.portsmouth.uk.ibm.com
X-IBM-MailFrom: gkurz@linux.vnet.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 336342190056
        for <linux-mips@linux-mips.org>; Thu, 21 Apr 2016 18:18:33 +0100 (BST)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com [9.149.37.252])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u3LHItAU3211606
        for <linux-mips@linux-mips.org>; Thu, 21 Apr 2016 17:18:55 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u3LHIsns023674
        for <linux-mips@linux-mips.org>; Thu, 21 Apr 2016 11:18:55 -0600
Received: from smtp.lab.toulouse-stg.fr.ibm.com (srv01.lab.toulouse-stg.fr.ibm.com [9.101.4.1])
        by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u3LHIsxG023670;
        Thu, 21 Apr 2016 11:18:54 -0600
Received: from bahia.huguette.org (sig-9-83-160-41.evts.uk.ibm.com [9.83.160.41])
        by smtp.lab.toulouse-stg.fr.ibm.com (Postfix) with ESMTP id 0DF87220077;
        Thu, 21 Apr 2016 19:18:52 +0200 (CEST)
Date:   Thu, 21 Apr 2016 19:18:50 +0200
From:   Greg Kurz <gkurz@linux.vnet.ibm.com>
To:     Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, james.hogan@imgtec.com,
        mingo@redhat.com, linux-mips@linux-mips.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, qemu-ppc@nongnu.org,
        Cornelia Huck <cornelia.huck@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3] KVM: remove buggy vcpu id check on vcpu creation
Message-ID: <20160421191850.65a07e86@bahia.huguette.org>
In-Reply-To: <20160421160841.GD25335@potion>
References: <146116689259.20666.15860134511726195550.stgit@bahia.huguette.org>
        <20160420182909.GB4044@potion>
        <20160421132958.0e9292d5@bahia.huguette.org>
        <20160421152916.GA30356@potion>
        <20160421174956.1049e0a5@bahia.huguette.org>
        <20160421160841.GD25335@potion>
Organization: IBM
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16042117-0029-0000-0000-000013E70B15
Return-Path: <gkurz@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53183
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gkurz@linux.vnet.ibm.com
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

On Thu, 21 Apr 2016 18:08:41 +0200
Radim Krčmář <rkrcmar@redhat.com> wrote:

> 2016-04-21 17:49+0200, Greg Kurz:
> > So we're good ?  
> 
> I support the change, just had a nit about API design for v2.
> 

As I said in my other mail, I'm not sure we should do more... if
that's okay for you and you still support the change, maybe you
can give an Acked-by ?

> >                 Whose tree can carry these patches ?  
> 
> (PowerPC is the only immediately affected arch, so I'd it there.)
> 
> What do you think is best?  My experience in this regard is pretty low.
> 

Maybe Paolo's tree but I guess we'd need some more acks from x86, ARM and
PowerPC :) KVM maintainers...

Thanks anyway for your valuable help !

Cheers.

--
Greg
