Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Apr 2016 19:39:43 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:38456 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27026632AbcDURjmKXgpB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 Apr 2016 19:39:42 +0200
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A4319800AF;
        Thu, 21 Apr 2016 17:39:35 +0000 (UTC)
Received: from potion (dhcp-1-215.brq.redhat.com [10.34.1.215])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u3LHdVs3002252;
        Thu, 21 Apr 2016 13:39:32 -0400
Received: by potion (sSMTP sendmail emulation); Thu, 21 Apr 2016 19:39:31 +0200
Date:   Thu, 21 Apr 2016 19:39:31 +0200
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     Greg Kurz <gkurz@linux.vnet.ibm.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, james.hogan@imgtec.com,
        mingo@redhat.com, linux-mips@linux-mips.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, qemu-ppc@nongnu.org,
        Cornelia Huck <cornelia.huck@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3] KVM: remove buggy vcpu id check on vcpu creation
Message-ID: <20160421173931.GB31953@potion>
References: <146116689259.20666.15860134511726195550.stgit@bahia.huguette.org>
 <20160420182909.GB4044@potion>
 <20160421132958.0e9292d5@bahia.huguette.org>
 <20160421152916.GA30356@potion>
 <20160421174956.1049e0a5@bahia.huguette.org>
 <20160421160841.GD25335@potion>
 <20160421191850.65a07e86@bahia.huguette.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160421191850.65a07e86@bahia.huguette.org>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Return-Path: <rkrcmar@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53185
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

2016-04-21 19:18+0200, Greg Kurz:
> On Thu, 21 Apr 2016 18:08:41 +0200
> Radim Krčmář <rkrcmar@redhat.com> wrote:
>> 2016-04-21 17:49+0200, Greg Kurz:
>> > So we're good ?  
>> 
>> I support the change, just had a nit about API design for v2.
>> 
> 
> As I said in my other mail, I'm not sure we should do more... if
> that's okay for you and you still support the change, maybe you
> can give an Acked-by ?

I'm evil when it comes to APIs, so bear it a bit longer. :)

>> >                 Whose tree can carry these patches ?  
>> 
>> (PowerPC is the only immediately affected arch, so I'd it there.)
>> 
>> What do you think is best?  My experience in this regard is pretty low.
>> 
> 
> Maybe Paolo's tree but I guess we'd need some more acks from x86, ARM and
> PowerPC :) KVM maintainers...

Ok.
