Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Mar 2010 12:35:47 +0100 (CET)
Received: from mail-gw0-f49.google.com ([74.125.83.49]:46412 "EHLO
        mail-gw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490999Ab0CDLfo convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 4 Mar 2010 12:35:44 +0100
Received: by gwj21 with SMTP id 21so1207305gwj.36
        for <multiple recipients>; Thu, 04 Mar 2010 03:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=n6BWJSZcHse9VR/zabGgrG6JXxxZ2rfAv/ox4xolTNQ=;
        b=oanIZCHFDUpKSCP2vr/w8qa7RAN4BPtH9/AvFHzoS7FPfDFmm/MpacOBBoKqWVnlnQ
         MW6tYN5gRv6sWV4iQ1Stpxb62D+Q333yK3jXqr+4C8P5gVKUYMeiq99ZL9TNMHq2Z8sT
         X7JFX+Pqa+IvcgkKVxSN7JyGlB1PIfTLY1Zqg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=aZqQ++K1j9vp/CgSqZumIId19i6V835JE9t7f2oKjh7eyjKe6pVWwIEyDB8iPYb8GD
         kqzSZapna0o7m3QdnUex2qS6yuYtVOwOSP3jI6V4J1kkHdx3Mx1jufnyEGKC+hRpsEaE
         u2OWTnsD4hAI58c5o0sfwgUXEFVHFKPQ0vPyA=
MIME-Version: 1.0
Received: by 10.150.81.5 with SMTP id e5mr2390216ybb.158.1267702537387; Thu, 
        04 Mar 2010 03:35:37 -0800 (PST)
In-Reply-To: <4B8E9E0C.4050809@caviumnetworks.com>
References: <20100303110527.11233.20400.stgit@muvarov>
         <4B8E9E0C.4050809@caviumnetworks.com>
Date:   Thu, 4 Mar 2010 14:35:37 +0300
Message-ID: <572af9171003040335w16434350y60a9f39676dbfa3d@mail.gmail.com>
Subject: Re: [PATCH 1/2] MIPS kexec,kdump support
From:   Maxim Uvarov <muvarov@gmail.com>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, kexec@lists.infradead.org,
        horms@verge.net.au, ralf@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <muvarov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26122
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: muvarov@gmail.com
Precedence: bulk
X-list: linux-mips

2010/3/3 David Daney <ddaney@caviumnetworks.com>:
> On 03/03/2010 03:05 AM, Maxim Uvarov wrote:
>>
>> Hello folks,
>>
>> Please find here MIPS crash and kdump patches.
>> This is patch set of 3 patches:
>> 1. generic MIPS changes (kernel);
>> 2. MIPS Cavium Octeon board kexec/kdump code (kernel);
>> 3. Kexec user space MIPS changes.
>>
>> Patches were tested on the latest linux-mips@ git kernel and the latest
>> kexec-tools git on Cavium Octeon 50xx board.
>>
>> I also made the same code working on RMI XLR/XLS boards for both
>> mips32 and mips64 kernels.
>>
>> Best regards,
>> Maxim Uvarov.
>>
>>
>> ---
>>
>>  arch/mips/Kconfig                  |   24 ++++++++++
>
> [...]
>>
>>
>> Signed-off-by: Maxim Uvarov<muvarov@gmail.com>
>>
>
> That Signed-off-by: needs to be just above the '---' not at the end.
>
> David Daney
>
Thanks David, I corrected stgit email template. I think I don't need
resend patches with only this change.


-- 
Best regards,
Maxim Uvarov
