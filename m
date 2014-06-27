Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jun 2014 16:53:43 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:57307 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817913AbaF0OxlxvoGz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 Jun 2014 16:53:41 +0200
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s5RERvF9006605
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jun 2014 10:27:58 -0400
Received: from yakj.usersys.redhat.com (ovpn-112-58.ams2.redhat.com [10.36.112.58])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s5RERqHV005885;
        Fri, 27 Jun 2014 10:27:54 -0400
Message-ID: <53AD7F68.5000304@redhat.com>
Date:   Fri, 27 Jun 2014 16:27:52 +0200
From:   Paolo Bonzini <pbonzini@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>,
        David Daney <ddaney.cavm@gmail.com>
CC:     gleb@kernel.org, kvm@vger.kernel.org, sanjayl@kymasys.com,
        james.hogan@imgtec.com, ralf@linux-mips.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v4 5/7] MIPS: KVM: Rename files to remove the prefix "kvm_"
 and "kvm_mips_"
References: <1403809900-17454-1-git-send-email-dengcheng.zhu@imgtec.com> <1403809900-17454-6-git-send-email-dengcheng.zhu@imgtec.com> <53AC7466.6070401@gmail.com> <53AC7AAD.7010007@imgtec.com> <53AC96D7.8040208@gmail.com> <53ACA261.7040007@imgtec.com>
In-Reply-To: <53ACA261.7040007@imgtec.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Return-Path: <pbonzini@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40868
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

Il 27/06/2014 00:44, Deng-Cheng Zhu ha scritto:
>>>
>>>>
>>>> x86 calls these things irq.c and irq.h, perhaps that would be a little
>>>> better.
>>>
>>> There's also include/linux/irq.h
>>>
>>
>> Yes, I know.
>
> I simply wanted to let you know that if arch/mips/kvm/interrupt.h and
> include/linux/interrupt.h are consufing, then arch/x86/kvm/irq.h and
> include/linux/irq.h the same -- not even a little better.

And one of them is included as <linux/irq.h>, the other as "irq.h".  So 
there's no possibility of confusion.

"kvm_mips_" seems totally useless as a prefix.  I'm ambivalent with 
respect to removing the "kvm_" prefix; I'll apply the patch.

Paolo
