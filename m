Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jun 2017 17:08:15 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:46556 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992143AbdFTPIHdOiri (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 20 Jun 2017 17:08:07 +0200
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E64B93DBEB;
        Tue, 20 Jun 2017 15:08:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com E64B93DBEB
Authentication-Results: ext-mx06.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx06.extmail.prod.ext.phx2.redhat.com; spf=pass smtp.mailfrom=rkrcmar@redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.redhat.com E64B93DBEB
Received: from potion (unknown [10.43.2.65])
        by smtp.corp.redhat.com (Postfix) with SMTP id 08F7358858;
        Tue, 20 Jun 2017 15:07:57 +0000 (UTC)
Received: by potion (sSMTP sendmail emulation); Tue, 20 Jun 2017 17:07:57 +0200
Date:   Tue, 20 Jun 2017 17:07:57 +0200
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     James Cowgill <James.Cowgill@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH v2] KVM: MIPS: Fix maybe-uninitialized build failure
Message-ID: <20170620150756.GE10325@potion>
References: <20170620095751.5443-1-James.Cowgill@imgtec.com>
 <20170620145432.GV6973@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170620145432.GV6973@jhogan-linux.le.imgtec.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 20 Jun 2017 15:08:01 +0000 (UTC)
Return-Path: <rkrcmar@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58690
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

2017-06-20 15:54+0100, James Hogan:
> Acked-by: James Hogan <james.hogan@imgtec.com>
> 
> Paolo / Radim: is it okay for one of you to pick this one up for 4.12?

It's in, thanks!
