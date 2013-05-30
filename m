Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 May 2013 22:11:55 +0200 (CEST)
Received: from mail-ea0-f182.google.com ([209.85.215.182]:51955 "EHLO
        mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822345Ab3E3ULuOm0og (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 May 2013 22:11:50 +0200
Received: by mail-ea0-f182.google.com with SMTP id r16so797327ead.41
        for <multiple recipients>; Thu, 30 May 2013 13:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=d7deQiimkzlFIfd1eB/+8DQ7HvcIVJ0GeCes6a5I0E0=;
        b=Ll97P66ff794GNFlhTp6kxdlZv347uSnNiG8mq82dKA/lnP4qg9m93Ki10cnLKBrp+
         uk/yuObs8RtU+fRxo0ILapIFgZMFlUHISKJOKUYDv4+9lhsKrkrvtOhVfDCnszZTUGBD
         ydl3uCoSbDGfJ/Biy/yIJqQrc/n0Z//AWPWXRZ4ARTZW2r92mnCE/YXRTWY/J0TZysZy
         nmQ1M9esstutj0TiVw5qrjyjRKtqg9IwVtSZqUKWjWL3H3C8+riytksRJCP51u2y2Cn1
         hGsztTB/WM7gq8CkruU0BxJe4WGKgLT1lrWtAPxmNzWYtfMdDsFF+fTqn0ORYw3IkPHm
         2bZA==
X-Received: by 10.15.23.4 with SMTP id g4mr11010640eeu.107.1369944704851;
        Thu, 30 May 2013 13:11:44 -0700 (PDT)
Received: from yakj.usersys.redhat.com (net-37-116-217-184.cust.dsl.vodafone.it. [37.116.217.184])
        by mx.google.com with ESMTPSA id z52sm62470578eea.1.2013.05.30.13.11.41
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 30 May 2013 13:11:43 -0700 (PDT)
Message-ID: <51A7B273.1060609@redhat.com>
Date:   Thu, 30 May 2013 22:11:31 +0200
From:   Paolo Bonzini <pbonzini@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130514 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Sanjay Lal <sanjayl@kymasys.com>
CC:     kvm@vger.kernel.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 06/18] KVM/MIPS32-VZ: VZ-ASE related callbacks to handle
 guest exceptions that trap to the Root context.
References: <n> <1368942460-15577-1-git-send-email-sanjayl@kymasys.com> <1368942460-15577-7-git-send-email-sanjayl@kymasys.com> <51A4D7F8.3060300@redhat.com> <2F16EB10-AFB8-4922-BAC1-EDCED4CC540E@kymasys.com>
In-Reply-To: <2F16EB10-AFB8-4922-BAC1-EDCED4CC540E@kymasys.com>
X-Enigmail-Version: 1.5.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <paolo.bonzini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36656
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

Il 30/05/2013 20:35, Sanjay Lal ha scritto:
>>> >> +#endif
>>> >> +		local_irq_save(flags);
>>> >> +		if (kvm_mips_handle_vz_root_tlb_fault(badvaddr, vcpu) < 0) {
>>> >> +			run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
>>> >> +			er = EMULATE_FAIL;
>>> >> +		}
>>> >> +		local_irq_restore(flags);
>>> >> +	}
>> > 
>> > This is introduced much later.  Please make sure that, with
>> > CONFIG_KVM_MIPS_VZ, every patch builds.
>> > 
>> > Paolo
>> > 
> Again, I think this has to do with the fact that the patches were
> against 3.10-rc2, will rebase for v2.

No, this is a simple patch ordering problem.
kvm_mips_handle_vz_root_tlb_fault is added in patch 11 only.

Paolo
