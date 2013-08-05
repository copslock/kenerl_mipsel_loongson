Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Aug 2013 15:43:45 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:43044 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6819547Ab3HENnnJdFTO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 5 Aug 2013 15:43:43 +0200
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r75DhSET000533
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Mon, 5 Aug 2013 09:43:29 -0400
Received: from dhcp-1-237.tlv.redhat.com (dhcp-4-97.tlv.redhat.com [10.35.4.97])
        by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id r75DhRWj003613;
        Mon, 5 Aug 2013 09:43:27 -0400
Received: by dhcp-1-237.tlv.redhat.com (Postfix, from userid 13519)
        id 2A00F1336CE; Mon,  5 Aug 2013 16:43:27 +0300 (IDT)
Date:   Mon, 5 Aug 2013 16:43:27 +0300
From:   Gleb Natapov <gleb@redhat.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@imgtec.com>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 1/3] mips/kvm: Improve code formatting in
 arch/mips/kvm/kvm_locore.S
Message-ID: <20130805134326.GA15901@redhat.com>
References: <1375388555-4045-1-git-send-email-ddaney.cavm@gmail.com>
 <1375388555-4045-2-git-send-email-ddaney.cavm@gmail.com>
 <51FFA5CD.3010406@imgtec.com>
 <20130805132157.GB3470@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130805132157.GB3470@linux-mips.org>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Return-Path: <gleb@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37430
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gleb@redhat.com
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

On Mon, Aug 05, 2013 at 03:21:57PM +0200, Ralf Baechle wrote:
> On Mon, Aug 05, 2013 at 02:17:01PM +0100, James Hogan wrote:
> 
> > 
> > On 01/08/13 21:22, David Daney wrote:
> > > From: David Daney <david.daney@cavium.com>
> > > 
> > > No code changes, just reflowing some comments and consistently using
> > > tabs and spaces.  Object code is verified to be unchanged.
> > > 
> > > Signed-off-by: David Daney <david.daney@cavium.com>
> > > Acked-by: Ralf Baechle <ralf@linux-mips.org>
> > 
> > 
> > > +   	 /* Put the saved pointer to vcpu (s1) back into the DDATA_LO Register */
> > 
> > git am detects a whitespace error here ("space before tab in indent").
> > It's got spaces before and after the tab actually.
> > 
> > >      /* load the guest context from VCPU and return */
> > 
> > this comment could have it's indentation fixed too
> > 
> > Otherwise, for all 3 patches:
> > 
> > Reviewed-by: James Hogan <james.hogan@imgtec.com>
> 
> I'm happy with the patch series as well and will fix this issue when
> applying the patch.
> 
kvm fixes usually go through kvm.git tree for all arches. Any special
reasons you want to get those through mips tree?

--
			Gleb.
