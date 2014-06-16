Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jun 2014 18:34:44 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:16856 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6859971AbaFPQemFbzX6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 16 Jun 2014 18:34:42 +0200
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s5GGXPAg008950
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jun 2014 12:33:25 -0400
Received: from yakj.usersys.redhat.com (ovpn-112-52.ams2.redhat.com [10.36.112.52])
        by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s5GGXKrX019567;
        Mon, 16 Jun 2014 12:33:21 -0400
Message-ID: <539F1C50.3090604@redhat.com>
Date:   Mon, 16 Jun 2014 18:33:20 +0200
From:   Paolo Bonzini <pbonzini@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>
CC:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        Gleb Natapov <gleb@kernel.org>, kvm@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: Re: [PATCH v2 00/23] MIPS: KVM: Fixes and guest timer rewrite
References: <1401355005-20370-1-git-send-email-james.hogan@imgtec.com> <53870DAD.7050900@redhat.com> <53874719.5070604@imgtec.com> <538750F8.7040202@redhat.com> <53875FEE.1020607@imgtec.com> <53876850.20600@redhat.com> <53879C3E.3040102@imgtec.com> <538839DE.3000804@redhat.com> <539F1B76.8090601@imgtec.com>
In-Reply-To: <539F1B76.8090601@imgtec.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
Return-Path: <pbonzini@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40529
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

Il 16/06/2014 18:29, James Hogan ha scritto:
>> Rather than adding comments, we might as well force it to be always zero
>> and just write get_clock() to COUNT_RESUME.
>>
>> Finally, having to serialize env->count_save_time makes harder to
>> support migration from TCG to KVM and back.
>
> Yes, I'm not keen on that bit of code.

Are you going to submit it for 2.1?  There are still a few days for 
review and inclusion.

Paolo
