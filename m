Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Feb 2013 15:18:08 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:57515 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825735Ab3BFOSDwj-3m (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 6 Feb 2013 15:18:03 +0100
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r16EG9MW005095
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Wed, 6 Feb 2013 09:18:00 -0500
Received: from dhcp-1-237.tlv.redhat.com (dhcp-4-26.tlv.redhat.com [10.35.4.26])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id r16DKIcc003858;
        Wed, 6 Feb 2013 08:20:23 -0500
Received: by dhcp-1-237.tlv.redhat.com (Postfix, from userid 13519)
        id 423DB18D479; Wed,  6 Feb 2013 15:20:18 +0200 (IST)
Date:   Wed, 6 Feb 2013 15:20:18 +0200
From:   Gleb Natapov <gleb@redhat.com>
To:     Sanjay Lal <sanjayl@kymasys.com>
Cc:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v2 11/18] KVM/MIPS32: Routines to handle specific
 traps/exceptions while executing the guest.
Message-ID: <20130206132018.GC7837@redhat.com>
References: <1353551656-23579-1-git-send-email-sanjayl@kymasys.com>
 <1353551656-23579-12-git-send-email-sanjayl@kymasys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1353551656-23579-12-git-send-email-sanjayl@kymasys.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
X-archive-position: 35717
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, Nov 21, 2012 at 06:34:09PM -0800, Sanjay Lal wrote:
> +static gpa_t kvm_trap_emul_gva_to_gpa_cb(gva_t gva)
> +{
> +	gpa_t gpa;
> +	uint32_t kseg = KSEGX(gva);
> +
> +	if ((kseg == CKSEG0) || (kseg == CKSEG1))
You seems to be using KVM_GUEST_KSEGX variants on gva in all other
places. Why not here?

> +		gpa = CPHYSADDR(gva);
> +	else {
> +		printk("%s: cannot find GPA for GVA: %#lx\n", __func__, gva);
> +		kvm_mips_dump_host_tlbs();
> +		gpa = KVM_INVALID_ADDR;
> +	}
> +
> +#ifdef DEBUG
> +	kvm_debug("%s: gva %#lx, gpa: %#llx\n", __func__, gva, gpa);
> +#endif
> +
> +	return gpa;
> +}
> +

--
			Gleb.
