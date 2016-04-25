Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Apr 2016 16:15:31 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:34530 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27026065AbcDYOPaJIOfR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Apr 2016 16:15:30 +0200
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CD1E3C049D4F;
        Mon, 25 Apr 2016 14:15:27 +0000 (UTC)
Received: from potion (dhcp-1-215.brq.redhat.com [10.34.1.215])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u3PEFNJX002044;
        Mon, 25 Apr 2016 10:15:23 -0400
Received: by potion (sSMTP sendmail emulation); Mon, 25 Apr 2016 16:15:22 +0200
Date:   Mon, 25 Apr 2016 16:15:22 +0200
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     Greg Kurz <gkurz@linux.vnet.ibm.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, james.hogan@imgtec.com,
        mingo@redhat.com, linux-mips@linux-mips.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        David Hildenbrand <dahi@linux.vnet.ibm.com>,
        qemu-ppc@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v4 2/2] KVM: move vcpu id checking to archs
Message-ID: <20160425141522.GB2386@potion>
References: <146124809455.32509.15232948272580716135.stgit@bahia.huguette.org>
 <146124811255.32509.17679765789502091772.stgit@bahia.huguette.org>
 <20160421160018.GA31953@potion>
 <20160421184500.6cb5fd8a@bahia.huguette.org>
 <20160421173611.GB30356@potion>
 <20160422112538.41b23a9d@bahia.huguette.org>
 <20160422134029.GE25335@potion>
 <20160422165024.0d85d31d@bahia.huguette.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160422165024.0d85d31d@bahia.huguette.org>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Return-Path: <rkrcmar@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53228
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rkrcmar@redhat.com
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

2016-04-22 16:50+0200, Greg Kurz:
> Just to be sure I haven't missed something:
> - change the spec to introduce the MAX_VCPU_ID concept
> - update all related checks in KVM
> - provide a KVM_CAP_MAX_VCPU_ID for userspace

That is it, thanks a lot!

(From nitpicks that come to my mind ... MAX_VCPU_ID should not be able
 to lower the VCPU_ID limit below MAX_VCPUS.)
