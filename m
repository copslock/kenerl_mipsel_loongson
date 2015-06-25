Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Jun 2015 16:26:41 +0200 (CEST)
Received: from mail-lb0-f169.google.com ([209.85.217.169]:35817 "EHLO
        mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009022AbbFYO0jicWrM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Jun 2015 16:26:39 +0200
Received: by lbbwc1 with SMTP id wc1so46649537lbb.2
        for <linux-mips@linux-mips.org>; Thu, 25 Jun 2015 07:26:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=t8pxKeBDWvaGmjVOwRN9wUlxdTdegSINilY/vPDU+dY=;
        b=JjnP/vysIChMDbRBXav4fNwswnYnZAPaN2I0ePDto2hcVFGwqhotsMTZFQGuDFvxCN
         WH8sUFZD+pOb8BjVFnqOe//bK5UYXCoI4VPAoK4/WqqKqzOilo+0J3sO/pWznc2zgVVJ
         k7nnSgp63+ordWwDSqu1WaMZoS9odhD4jbfDdevJlKHjBpYmesl6U/aBMyzRGvQH5UMR
         JA3WN5RcG3HLo0usV8kGE8apne5ZzLu6FtkwDH8Z7nhM/TlhAvX+GRH2iaaq8KyClfp4
         J0ceEkNMHdhfls9HevUbL5sWliH/+w5z/DQYiF0kUb0r/+9vatWqxP+8NKePHjr0UJYt
         Rk4Q==
X-Gm-Message-State: ALoCoQn84daqAbX9Q28IhlgM+wQiJu3M3D98mgzNGelQkA9ts7cx2Izbd2Fo22n8IPMYPIRvg4wH
X-Received: by 10.112.125.65 with SMTP id mo1mr45975050lbb.0.1435242393829;
 Thu, 25 Jun 2015 07:26:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.152.170.233 with HTTP; Thu, 25 Jun 2015 07:26:14 -0700 (PDT)
In-Reply-To: <20150625141638.GF2329@akamai.com>
References: <1433942810-7852-1-git-send-email-emunson@akamai.com>
 <20150610145929.b22be8647887ea7091b09ae1@linux-foundation.org>
 <5579DFBA.80809@akamai.com> <20150611123424.4bb07cffd0e5bb146cc92231@linux-foundation.org>
 <557ACAFC.90608@suse.cz> <20150615144356.GB12300@akamai.com>
 <55895956.5020707@suse.cz> <20150625141638.GF2329@akamai.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Thu, 25 Jun 2015 07:26:14 -0700
Message-ID: <CALCETrW5LWgcuezfNDGYmivydsM2U36MLS6n1ardmLgsSrAdmQ@mail.gmail.com>
Subject: Re: [RESEND PATCH V2 0/3] Allow user to request memory to be locked
 on page fault
To:     Eric B Munson <emunson@akamai.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        Michal Hocko <mhocko@suse.cz>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-alpha@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48030
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luto@amacapital.net
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

On Thu, Jun 25, 2015 at 7:16 AM, Eric B Munson <emunson@akamai.com> wrote:
> On Tue, 23 Jun 2015, Vlastimil Babka wrote:
>
>> On 06/15/2015 04:43 PM, Eric B Munson wrote:
>> >>
>> >>If the new LOCKONFAULT functionality is indeed desired (I haven't
>> >>still decided myself) then I agree that would be the cleanest way.
>> >
>> >Do you disagree with the use cases I have listed or do you think there
>> >is a better way of addressing those cases?
>>
>> I'm somewhat sceptical about the security one. Are security
>> sensitive buffers that large to matter? The performance one is more
>> convincing and I don't see a better way, so OK.
>
> They can be, the two that come to mind are medical images and high
> resolution sensor data.

I think we've been handling sensitive memory pages wrong forever.  We
shouldn't lock them into memory; we should flag them as sensitive and
encrypt them if they're ever written out to disk.

--Andy
