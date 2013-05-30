Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 May 2013 19:51:47 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:58340 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823608Ab3E3RviIh59V (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 30 May 2013 19:51:38 +0200
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4UHpST8006557
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 30 May 2013 13:51:28 -0400
Received: from yakj.usersys.redhat.com (ovpn-112-38.ams2.redhat.com [10.36.112.38])
        by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id r4UHpO3O017472;
        Thu, 30 May 2013 13:51:25 -0400
Message-ID: <51A79193.6080908@redhat.com>
Date:   Thu, 30 May 2013 19:51:15 +0200
From:   Paolo Bonzini <pbonzini@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130514 Thunderbird/17.0.6
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     Sanjay Lal <sanjayl@kymasys.com>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 10/18] KVM/MIPS32-VZ: Add API for VZ-ASE Capability
References: <n> <1368942460-15577-1-git-send-email-sanjayl@kymasys.com> <1368942460-15577-11-git-send-email-sanjayl@kymasys.com> <51A4DC99.7040706@redhat.com> <51A7875F.4080606@gmail.com>
In-Reply-To: <51A7875F.4080606@gmail.com>
X-Enigmail-Version: 1.5.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.25
Return-Path: <pbonzini@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36648
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

Il 30/05/2013 19:07, David Daney ha scritto:
> On 05/28/2013 09:34 AM, Paolo Bonzini wrote:
>> Il 19/05/2013 07:47, Sanjay Lal ha scritto:
>>> - Add API to allow clients (QEMU etc.) to check whether the H/W
>>>    supports the MIPS VZ-ASE.
>>
>> Why does this matter to userspace?  Do the userspace have some way to
>> detect if the kernel is unmodified or minimally-modified?
>>
> 
> There are (will be) two types of VM presented by MIPS KVM:
> 
> 1) That provided by the initial patch where a faux-MIPS is emulated and
> all kernel code must be in the USEG address space.
> 
> 2) Real MIPS, addressing works as per the architecture specification.
> 
> Presumably the user-space client would like to know which of these are
> supported, as well as be able to select the desired model.

Understood.  It's really two different machine types.

> I don't know the best way to do this, but I agree that
> KVM_CAP_MIPS_VZ_ASE is probably not the best name for it.
> 
> My idea was to have the arg of the KVM_CREATE_VM ioctl specify the
> desired style

Ok.  How complex is it?  Do you plan to do this when the patches are
"really ready" for Linus' tree?

Paolo
