Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jun 2015 14:57:13 +0200 (CEST)
Received: from mail-wg0-f41.google.com ([74.125.82.41]:36646 "EHLO
        mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006891AbbFJM5KXBXzX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Jun 2015 14:57:10 +0200
Received: by wgbgq6 with SMTP id gq6so35157185wgb.3;
        Wed, 10 Jun 2015 05:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=jC6RISbj3mdqZo9GeZ7kfjTytHvHnXxQalc/HlY5Uyc=;
        b=musdlCy1uoO1GbZj5p26GYuXOzpKuZ8eOe6hDBOjXHjsDJOzniDQXbANHVEdNLEExm
         kqH6gX57fD4nAoj5fbTUgghMMWtvnDPSlBh2NllbTxias9vqiGrVtmSNFHDwTsGfH3K2
         e5n9yplcvn6zoBg+VLAWqwD3YVqCpmvsKe2LJb/gA0my4RyfjeCOkYP0KSFas22NfdCV
         ZRRu493GF9QkZFCcVwFAZG/ZfELI04wLczZ3kginy0cN9qg0cA7IILizKSRiEkqYv/h7
         CaBVEJGQUNS/dny8dZAEKpb0ycKHGrW4TRDxh6WCwv+gITkX5me0ZIeFofzJ1wgTaNJq
         blHA==
X-Received: by 10.194.3.77 with SMTP id a13mr6123029wja.104.1433941025137;
        Wed, 10 Jun 2015 05:57:05 -0700 (PDT)
Received: from ?IPv6:2a01:4240:53f0:43fb::cbb? (b.b.c.0.0.0.0.0.0.0.0.0.0.0.0.0.b.f.3.4.0.f.3.5.0.4.2.4.1.0.a.2.v6.cust.nbox.cz. [2a01:4240:53f0:43fb::cbb])
        by mx.google.com with ESMTPSA id m10sm7834612wib.17.2015.06.10.05.57.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jun 2015 05:57:04 -0700 (PDT)
Message-ID: <5578341E.3020709@suse.cz>
Date:   Wed, 10 Jun 2015 14:57:02 +0200
From:   Jiri Slaby <jslaby@suse.cz>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>,
        stable <stable@vger.kernel.org>
CC:     Nicholas Mc Guire <hofrat@osadl.org>,
        Gleb Natapov <gleb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: KVM: do not sign extend on unsigned MMIO load
References: <1431002870-30098-1-git-send-email-hofrat@osadl.org> <554CC530.20906@imgtec.com> <5575536E.8080608@imgtec.com>
In-Reply-To: <5575536E.8080608@imgtec.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <jirislaby@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47912
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jslaby@suse.cz
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

On 06/08/2015, 10:33 AM, James Hogan wrote:
> Hi stable folk,
> 
> On 08/05/15 15:16, James Hogan wrote:
>> On 07/05/15 13:47, Nicholas Mc Guire wrote:
>>> Fix possible unintended sign extension in unsigned MMIO loads
>>> by casting to uint16_t in the case of mmio_needed != 2.
>>> 
>>> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
>> 
>> Looks good to me. I wrote an MMIO test to reproduce the issue,
>> and this fixes it.
>> 
>> Reviewed-by: James Hogan <james.hogan@imgtec.com> Tested-by:
>> James Hogan <james.hogan@imgtec.com>
>> 
>> It looks suitable for stable too (3.10+).
> 
> This has reached mainline, commit
> ed9244e6c534612d2b5ae47feab2f55a0d4b4ced
> 
> Please could it be added to stable (3.10+).

Applied to 3.12. Thanks.

- -- 
js
suse labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVeDQcAAoJEL0lsQQGtHBJ7q4P/3Q7y1FHwPKDhsdIdyyRypR6
OXaH/6eNzpBhvSngP1gnx9MiyESTYihFVlRJsV6hYYzRcippnU0BP88dx9ntYrc1
Accbhj/PPYcMqfCnYdL80Kxt9EomeuxEDcCdbp8twnReTt44xNAGHePiNh9GrhjG
VKBMralyyjymtwyamCGb2W2aLNhxELIG3gXJTb7Q7E071LVeqQA6g+VNQ2QHwFYq
FkJexePsLu/j3zVxH+rsQPJA6E1oKfUJb3jQHAtZHAH95Um0r8T4jUVSgFhyk3r6
9tlkazL3P8Iui6lxbrV1vNCPAhhucY7PmX99uGhdroKJOKDCDPsVOKyJbxeHrUBR
3zrMpB9x2uXd6WpDLDfL+bI8bCG6NVXZPGgSd7P+r/UbNuZ6VBNSVdqlWUeoMWGR
ZS+HFMxVOiNplYudCTdLbJDLhm2XCWeW2lqszll/8Nk1c1FZkl8YbgpmdXfutKeU
LQfUfS4tr0AQ7BqXf3bPUGrSGZO7e1V5R4gAa+Yqo6ZjDOj20AjYvs0oW4ubgLg8
OJrHcJDLkEKrMDIZ7qpRZxyz56yrOgcfVbYB1fudXaV+e38t+kO0sujdNSJnHK8h
T3kfa96QW2gOi7Cys1o2OaQboY2wFxK3/YefX3Jn+N7tGedKUwF4IYHtj17YqX1/
8BkHSZZ9HQsJqyRAXBux
=qlvA
-----END PGP SIGNATURE-----
