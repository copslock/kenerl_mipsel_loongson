Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Nov 2015 15:59:54 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:33524 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013419AbbKKO7wH4Vre (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 Nov 2015 15:59:52 +0100
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        by mx1.redhat.com (Postfix) with ESMTPS id C42881309;
        Wed, 11 Nov 2015 14:59:47 +0000 (UTC)
Received: from [10.36.112.47] (ovpn-112-47.ams2.redhat.com [10.36.112.47])
        by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id tABExdQm027249
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 11 Nov 2015 09:59:43 -0500
Subject: Re: [PATCH 0/3] MIPS: KVM: Misc fixes
To:     James Hogan <james.hogan@imgtec.com>
References: <1447251680-5254-1-git-send-email-james.hogan@imgtec.com>
 <56435402.2050503@redhat.com>
 <20151111145712.GX26383@jhogan-linux.le.imgtec.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, Gleb Natapov <gleb@kernel.org>,
        linux-mips@linux-mips.org, kvm@vger.kernel.org,
        stable@vger.kernel.org
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <564357DB.9000904@redhat.com>
Date:   Wed, 11 Nov 2015 15:59:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <20151111145712.GX26383@jhogan-linux.le.imgtec.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
Return-Path: <pbonzini@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49891
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pbonzini@redhat.com
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256



On 11/11/2015 15:57, James Hogan wrote:
> Okay, no problem. As long as they can make v4.4.
> 
> For the record do you prefer not to receive patches during merge 
> window?

It's okay, at worst I won't process them for a few days or weeks.

Paolo
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWQ1fWAAoJEL/70l94x66D5mEIAJbKuP0oRsfMVhZGDlonqzOp
+ugEDNWAzC8tQas2joei0tBtmsFMKY+9NXbFUUthcE0Tn4TbfBi5rRpOfE7B+ekV
Y6sec+vp0AsplpQtNI3OdU8jrZqMYkWUK6ZBdOJrpdPzBzfmFkXuMdimLomhdlVl
8r6Vh6la7RohEJWxXBAaGEzgGqIQ25H+Xw/FNHo3Pk2ZPhI2EgusSlMby6w087kQ
nht5LSVn92Jvx7CNCsqAEhccO/a6XYiRXfW+nFCa/Z1DUvYoezgyXl7jWvyGwKj5
9y73jwIYop63B+KcEDTWZ6gKu2GDrT+TQod+IlWoWDk58PdQjxI1BNcqS+QMFlc=
=VHcV
-----END PGP SIGNATURE-----
