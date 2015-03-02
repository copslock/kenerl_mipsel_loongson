Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Mar 2015 23:16:05 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:33481 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007914AbbCBWQETVJGV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 2 Mar 2015 23:16:04 +0100
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t22MFoOb002428
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Mar 2015 17:15:50 -0500
Received: from amt.cnet (vpn1-5-33.gru2.redhat.com [10.97.5.33])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t22MFnCu021531;
        Mon, 2 Mar 2015 17:15:50 -0500
Received: from amt.cnet (localhost [127.0.0.1])
        by amt.cnet (Postfix) with ESMTP id 7099D100EA8;
        Mon,  2 Mar 2015 19:15:39 -0300 (BRT)
Received: (from marcelo@localhost)
        by amt.cnet (8.14.7/8.14.7/Submit) id t22MFaPb004108;
        Mon, 2 Mar 2015 19:15:36 -0300
Date:   Mon, 2 Mar 2015 19:15:36 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: KVM: Fix trace event to save PC directly
Message-ID: <20150302221536.GA4095@amt.cnet>
References: <1424778380-28036-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1424778380-28036-1-git-send-email-james.hogan@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Return-Path: <mtosatti@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46078
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mtosatti@redhat.com
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

On Tue, Feb 24, 2015 at 11:46:20AM +0000, James Hogan wrote:
> Currently the guest exit trace event saves the VCPU pointer to the
> structure, and the guest PC is retrieved by dereferencing it when the
> event is printed rather than directly from the trace record. This isn't
> safe as the printing may occur long afterwards, after the PC has changed
> and potentially after the VCPU has been freed. Usually this results in
> the same (wrong) PC being printed for multiple trace events. It also
> isn't portable as userland has no way to access the VCPU data structure
> when interpreting the trace record itself.
> 
> Lets save the actual PC in the structure so that the correct value is
> accessible later.

Applied, thanks.
