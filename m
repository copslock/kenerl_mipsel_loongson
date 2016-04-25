Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Apr 2016 16:31:11 +0200 (CEST)
Received: from e06smtp05.uk.ibm.com ([195.75.94.101]:49745 "EHLO
        e06smtp05.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026065AbcDYObHid5U3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Apr 2016 16:31:07 +0200
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <gkurz@linux.vnet.ibm.com>;
        Mon, 25 Apr 2016 15:31:02 +0100
Received: from d06dlp01.portsmouth.uk.ibm.com (9.149.20.13)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Mon, 25 Apr 2016 15:31:00 +0100
X-IBM-Helo: d06dlp01.portsmouth.uk.ibm.com
X-IBM-MailFrom: gkurz@linux.vnet.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0072F17D805F
        for <linux-mips@linux-mips.org>; Mon, 25 Apr 2016 15:31:49 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com [9.149.37.249])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u3PEUxnf50266164
        for <linux-mips@linux-mips.org>; Mon, 25 Apr 2016 14:30:59 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u3PEUxjp003933
        for <linux-mips@linux-mips.org>; Mon, 25 Apr 2016 08:30:59 -0600
Received: from smtp.lab.toulouse-stg.fr.ibm.com (srv01.lab.toulouse-stg.fr.ibm.com [9.101.4.1])
        by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u3PEUw3A003886;
        Mon, 25 Apr 2016 08:30:59 -0600
Received: from bahia.huguette.org (sig-9-83-160-41.evts.uk.ibm.com [9.83.160.41])
        by smtp.lab.toulouse-stg.fr.ibm.com (Postfix) with ESMTP id 629B6220219;
        Mon, 25 Apr 2016 16:30:57 +0200 (CEST)
Date:   Mon, 25 Apr 2016 16:30:54 +0200
From:   Greg Kurz <gkurz@linux.vnet.ibm.com>
To:     Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, james.hogan@imgtec.com,
        mingo@redhat.com, linux-mips@linux-mips.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        David Hildenbrand <dahi@linux.vnet.ibm.com>,
        qemu-ppc@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v4 2/2] KVM: move vcpu id checking to archs
Message-ID: <20160425163054.70422eda@bahia.huguette.org>
In-Reply-To: <20160425141522.GB2386@potion>
References: <146124809455.32509.15232948272580716135.stgit@bahia.huguette.org>
        <146124811255.32509.17679765789502091772.stgit@bahia.huguette.org>
        <20160421160018.GA31953@potion>
        <20160421184500.6cb5fd8a@bahia.huguette.org>
        <20160421173611.GB30356@potion>
        <20160422112538.41b23a9d@bahia.huguette.org>
        <20160422134029.GE25335@potion>
        <20160422165024.0d85d31d@bahia.huguette.org>
        <20160425141522.GB2386@potion>
Organization: IBM
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16042514-0021-0000-0000-0000199F256E
Return-Path: <gkurz@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53229
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

On Mon, 25 Apr 2016 16:15:22 +0200
Radim Krčmář <rkrcmar@redhat.com> wrote:

> 2016-04-22 16:50+0200, Greg Kurz:
> > Just to be sure I haven't missed something:
> > - change the spec to introduce the MAX_VCPU_ID concept
> > - update all related checks in KVM
> > - provide a KVM_CAP_MAX_VCPU_ID for userspace  
> 
> That is it, thanks a lot!
> 
> (From nitpicks that come to my mind ... MAX_VCPU_ID should not be able
>  to lower the VCPU_ID limit below MAX_VCPUS.)
> 

Indeed it shouldn't. Thanks for the tip !
