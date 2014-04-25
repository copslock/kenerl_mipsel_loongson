Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Apr 2014 22:29:35 +0200 (CEST)
Received: from mail-we0-f171.google.com ([74.125.82.171]:59264 "EHLO
        mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6843074AbaDYU3dlXEe0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Apr 2014 22:29:33 +0200
Received: by mail-we0-f171.google.com with SMTP id q59so214372wes.2
        for <linux-mips@linux-mips.org>; Fri, 25 Apr 2014 13:29:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :organization:user-agent:in-reply-to:references:mime-version
         :content-type;
        bh=dyEK9bF0FJhXdMwja7r2SW7oqAxharxpAV2SEHhghVY=;
        b=lA+o1no3XKfrnRipTQ0mTjjPk3TFkOtcRIKbMAF7+luHElewyIBuV4ILsai4+cp2yP
         YsKHeyOnRi3xLREyxufW2w8mvekfjRWIo4NwBtSlIkCGY+VjK2hvW/fM1vJxTqey5Hai
         yibxq74VmO8yLhw2RjvFIffxPNqQQyAbUZgPzlMZ65s9ChSt3qJJtMwH7qiHfFfbzFdJ
         rbavbFB60EyGdpmhc2GxrPbmTlNqN6eG1UkZHlgu7/23UJdXzdatVK8SqbvdXgNuP645
         2jt2qsV2NyFkaKZ1Q6djMQKwpi74aFWQkUZFi07OdiVbRvedglUu2cJ/muKcErZKAvzd
         80aw==
X-Gm-Message-State: ALoCoQkZ+TFW/maqm/KRE629qy0oK8DiTQVN0OO+Au70uub2puEut7E6vG4eaZVoqpP6k75mQ46k
X-Received: by 10.180.11.239 with SMTP id t15mr5224802wib.25.1398457768247;
        Fri, 25 Apr 2014 13:29:28 -0700 (PDT)
Received: from radagast.localnet (jahogan.plus.com. [212.159.75.221])
        by mx.google.com with ESMTPSA id v6sm12735669wjv.21.2014.04.25.13.29.26
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 25 Apr 2014 13:29:27 -0700 (PDT)
From:   James Hogan <james.hogan@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     David Daney <ddaney.cavm@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Gleb Natapov <gleb@kernel.org>, kvm@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: Re: [PATCH 05/21] MIPS: KVM: Add CP0_EPC KVM register access
Date:   Fri, 25 Apr 2014 21:29:18 +0100
Message-ID: <10468933.5AvfRZXSN7@radagast>
Organization: Imagination Technologies
User-Agent: KMail/4.11.5 (Linux/3.14.0+; KDE/4.11.5; x86_64; ; )
In-Reply-To: <535A90E1.2030705@gmail.com>
References: <1398439204-26171-1-git-send-email-james.hogan@imgtec.com> <1398439204-26171-6-git-send-email-james.hogan@imgtec.com> <535A90E1.2030705@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2325235.4a0bX7vO2r"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-Path: <james@albanarts.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39954
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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


--nextPart2325235.4a0bX7vO2r
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi David,

On Friday 25 April 2014 09:44:17 David Daney wrote:
> On 04/25/2014 08:19 AM, James Hogan wrote:
> > Contrary to the comment, the guest CP0_EPC register cannot be set via
> > kvm_regs, since it is distinct from the guest PC. Add the EPC register
> > to the KVM_{GET,SET}_ONE_REG ioctl interface.
> > 
> > Signed-off-by: James Hogan <james.hogan@imgtec.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Gleb Natapov <gleb@kernel.org>
> > Cc: kvm@vger.kernel.org
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: linux-mips@linux-mips.org
> > Cc: David Daney <david.daney@cavium.com>
> > Cc: Sanjay Lal <sanjayl@kymasys.com>
> 
> NACK...
> 
> > ---
> > 
> >   arch/mips/kvm/kvm_mips.c | 9 ++++++++-
> >   1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/mips/kvm/kvm_mips.c b/arch/mips/kvm/kvm_mips.c
> > index 46cea0bad518..db41876cbac5 100644
> > --- a/arch/mips/kvm/kvm_mips.c
> > +++ b/arch/mips/kvm/kvm_mips.c
> > @@ -512,6 +512,7 @@ kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
> > 
> >   #define KVM_REG_MIPS_CP0_COMPARE	MIPS_CP0_32(11, 0)
> >   #define KVM_REG_MIPS_CP0_STATUS		MIPS_CP0_32(12, 0)
> >   #define KVM_REG_MIPS_CP0_CAUSE		MIPS_CP0_32(13, 0)
> > 
> > +#define KVM_REG_MIPS_CP0_EPC		MIPS_CP0_64(14, 0)
> 
> This is already called KVM_REG_MIPS_PC, you cannot change that.

KVM_REG_MIPS_PC gets you vcpu->arch.pc, i.e. the next address of guest 
execution.

KVM_REG_MIPS_CP0_EPC gets you the guest's CP0 EPC register which is the PC of 
the last guest exception.

They are quite distinct state, even though vcpu->arch.pc is read from the 
*root context*'s CP0 EPC register after an exception or interrupt.

Cheers
James

> 
> >   #define KVM_REG_MIPS_CP0_EBASE		MIPS_CP0_32(15, 1)
> >   #define KVM_REG_MIPS_CP0_CONFIG		MIPS_CP0_32(16, 0)
> >   #define KVM_REG_MIPS_CP0_CONFIG1	MIPS_CP0_32(16, 1)
> > 
> > @@ -567,7 +568,7 @@ static u64 kvm_mips_get_one_regs[] = {
> > 
> >   	KVM_REG_MIPS_CP0_ENTRYHI,
> >   	KVM_REG_MIPS_CP0_STATUS,
> >   	KVM_REG_MIPS_CP0_CAUSE,
> > 
> > -	/* EPC set via kvm_regs, et al. */
> > +	KVM_REG_MIPS_CP0_EPC,
> > 
> >   	KVM_REG_MIPS_CP0_CONFIG,
> >   	KVM_REG_MIPS_CP0_CONFIG1,
> >   	KVM_REG_MIPS_CP0_CONFIG2,
> > 
> > @@ -620,6 +621,9 @@ static int kvm_mips_get_reg(struct kvm_vcpu *vcpu,
> > 
> >   	case KVM_REG_MIPS_CP0_CAUSE:
> >   		v = (long)kvm_read_c0_guest_cause(cop0);
> >   		break;
> > 
> > +	case KVM_REG_MIPS_CP0_EPC:
> > +		v = (long)kvm_read_c0_guest_epc(cop0);
> > +		break;
> > 
> >   	case KVM_REG_MIPS_CP0_ERROREPC:
> >   		v = (long)kvm_read_c0_guest_errorepc(cop0);
> >   		break;
> > 
> > @@ -716,6 +720,9 @@ static int kvm_mips_set_reg(struct kvm_vcpu *vcpu,
> > 
> >   	case KVM_REG_MIPS_CP0_CAUSE:
> >   		kvm_write_c0_guest_cause(cop0, v);
> >   		break;
> > 
> > +	case KVM_REG_MIPS_CP0_EPC:
> > +		kvm_write_c0_guest_epc(cop0, v);
> > +		break;
> > 
> >   	case KVM_REG_MIPS_CP0_ERROREPC:
> >   		kvm_write_c0_guest_errorepc(cop0, v);
> >   		break;

--nextPart2325235.4a0bX7vO2r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABAgAGBQJTWsWlAAoJEKHZs+irPybflzAP/iCr+/XRp8IfyYH8TTTtVluf
oAJ2qMZGqC+Jt9uA6+2T6PkaUiwuO115EtawbHmx9iWU2OnJECrGftw7lQn3PmqG
pNJErGWzrp3wEKMxKb9vDPjuXdN2eNm0LGG9STyZ3QP/x3eNH7OnnI5WKhTDbtoZ
hgWpLbrm+ArnEtaxV3WTKlYlOYp/9tLhG1Jd29/xR0CXsDhYs0bOCTW7SpJ7JiWg
Qf7J8Cls4DVv76sZZ8BCUsjLFWq9p+nEhRME08QAVpkXnvbeaRzuhLSkI9UhitC7
v2sxM25aN/vCN5QRwAdj5n5IEOl2fJo8/sztVICh1K3uwkPl2ik4r9z/eFOg+a1t
mFGt8PNa9crJ7L8zwNMysWRmY7beePwtoT1mbM14rZAMU/dIM5az64GPXYT3Kdjp
o/+CEeTHn7eQgqXGMxJh+bINUR4hfSXjnpPFdvC3BR13FogT9vt/cd0j4oxTahKf
EjJbROs4klXy7xBOvouEKd1jg9aoa1Sv+Tnd1HHT3GpS8AEpmvcFrQe0atFgz1X8
9GSVbBVJJNwZZjtX2jk6uIuP2CIUOCqbA4akQIhAbrKsHCyA2uGYiDJYicYJ4Hcr
hwHD2qwH4+3BfgIVVfkGPNzKxZ7RMwqUa6NsAD5JXyYFjaODr7CSYmKRvSlNlzcw
3UC9di2dgStPDjKM7qZm
=o2wg
-----END PGP SIGNATURE-----

--nextPart2325235.4a0bX7vO2r--
