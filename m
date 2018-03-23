Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2018 18:25:33 +0100 (CET)
Received: from mail-lf0-x244.google.com ([IPv6:2a00:1450:4010:c07::244]:39658
        "EHLO mail-lf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990656AbeCWRZ0jk5Bq convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Mar 2018 18:25:26 +0100
Received: by mail-lf0-x244.google.com with SMTP id p142-v6so19400380lfd.6;
        Fri, 23 Mar 2018 10:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+OZYzmT42h5SnWF0OczzPVpdipxT1C1TADxUtBA1ByE=;
        b=OMlmcj8clO1OhtW8TlROXMtuSBQs3b4vYoHzLtsQSLQDhAzTFgSd1w0fWr8joiDzB1
         BrOebu8owGbjefmKhhGLmhtadNI+jqT6C3FHwwI4hdszSJT6+AZUdctz5/GY7HnAMxEP
         PzTPeHlb+xsHuDV03Di0vInH+29WPFkbJxrbmPjPx5ZrrZk1f9RpTdqr7zl1LalYD+AQ
         FmwBsIVuZXGrmaAXuzjF044CHD8t4MXd7Rfw/8gAxRPJBNHMbSUKylxwpDuK7s/ONLqz
         B3cDGGcmlWF/6wrgLqSuWV+FW9B/nj4/3iLdUbWuelWpSO81f12q4iTNVi/AlMZ51W3g
         MTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+OZYzmT42h5SnWF0OczzPVpdipxT1C1TADxUtBA1ByE=;
        b=EJGSMJCgjMG/7I71zFTWAXI3+fJwrMlakqHR96amqnXcPQa1QDTPGrqXp/GaW9nyfM
         SEn+4O1FO0SkiKXWQ7wIhzBgl+PpPr3oKUs6sb8i+FgjrVS4fJQIBDqhWLTh1g3QWB5F
         DYkL/+oUyfRPxAE7cKwJzq5qHym4sGPOp5EZT0/YYGkWva+R+zpYtaMvkBxe8yfksMXb
         HHlD8wblFILpKK5rbUjTiH/YMeg2sGb91i0w/aqmO7MRMr9RtzTMxuwcFS9iwdau85SN
         DksuCd+bi0VVfb8D4Rqcozeu9R3qIToaYBfrL8X9JO2EwqrpTjDOSLHSVglt1zlOU0qh
         cWDA==
X-Gm-Message-State: AElRT7GJ4HyfWNHhJkIjyNiZK+w6x2QO6hlNWItoJazhM37Bh/jobZCx
        oZfvg+1XSF8D1RDfoPcRnhk=
X-Google-Smtp-Source: AG47ELs5zcJhgSg9vwDza07EaDR0FQ17bw+vBwBGrJupYOX3TXXRodca/W9uPN4u58MIyJuxfBeFnQ==
X-Received: by 10.46.157.214 with SMTP id x22mr19381421ljj.135.1521825918360;
        Fri, 23 Mar 2018 10:25:18 -0700 (PDT)
Received: from [192.168.1.3] (broadband-188-255-70-164.moscow.rt.ru. [188.255.70.164])
        by smtp.gmail.com with ESMTPSA id d73-v6sm2302283lfl.77.2018.03.23.10.25.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 10:25:17 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [RFC PATCH v2 0/2] Randomization of address chosen by mmap.
From:   Ilya Smith <blackzert@gmail.com>
In-Reply-To: <20180322135729.dbfd3575819c92c0f88c5c21@linux-foundation.org>
Date:   Fri, 23 Mar 2018 20:25:15 +0300
Cc:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        vgupta@synopsys.com, linux@armlinux.org.uk, tony.luck@intel.com,
        fenghua.yu@intel.com, jhogan@kernel.org, ralf@linux-mips.org,
        jejb@parisc-linux.org, Helge Deller <deller@gmx.de>,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, nyc@holomorphy.com, viro@zeniv.linux.org.uk,
        arnd@arndb.de, gregkh@linuxfoundation.org, deepa.kernel@gmail.com,
        mhocko@suse.com, hughd@google.com, kstewart@linuxfoundation.org,
        pombredanne@nexb.com, steve.capper@arm.com, punit.agrawal@arm.com,
        paul.burton@mips.com, aneesh.kumar@linux.vnet.ibm.com,
        npiggin@gmail.com, keescook@chromium.org, bhsharma@redhat.com,
        riel@redhat.com, nitin.m.gupta@oracle.com,
        kirill.shutemov@linux.intel.com, dan.j.williams@intel.com,
        jack@suse.cz, ross.zwisler@linux.intel.com, jglisse@redhat.com,
        willy@infradead.org, aarcange@redhat.com, oleg@redhat.com,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org
Content-Transfer-Encoding: 8BIT
Message-Id: <C43F853F-6B54-42DF-AEF2-64B22DAB8A1D@gmail.com>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
 <20180322135729.dbfd3575819c92c0f88c5c21@linux-foundation.org>
To:     Andrew Morton <akpm@linux-foundation.org>
X-Mailer: Apple Mail (2.3445.5.20)
Return-Path: <blackzert@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63170
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blackzert@gmail.com
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

Hello, Andrew

Thanks for reading this patch.

> On 22 Mar 2018, at 23:57, Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> On Thu, 22 Mar 2018 19:36:36 +0300 Ilya Smith <blackzert@gmail.com> wrote:
> 
>> Current implementation doesn't randomize address returned by mmap.
>> All the entropy ends with choosing mmap_base_addr at the process
>> creation. After that mmap build very predictable layout of address
>> space. It allows to bypass ASLR in many cases.
> 
> Perhaps some more effort on the problem description would help.  *Are*
> people predicting layouts at present?  What problems does this cause? 
> How are they doing this and are there other approaches to solving the
> problem?
> 
Sorry, I’ve lost it in first version. In short - memory layout could be easily 
repaired by single leakage. Also any Out of Bounds error may easily be 
exploited according to current implementation. All because mmap choose address 
just before previously allocated segment. You can read more about it here: 
http://www.openwall.com/lists/oss-security/2018/02/27/5
Some test are available here https://github.com/blackzert/aslur. 
To solve the problem Kernel should randomize address on any mmap so
attacker could never easily gain needed addresses.

> Mainly: what value does this patchset have to our users?  This reader
> is unable to determine that from the information which you have
> provided.  Full details, please.

The value of this patch is to decrease successful rate of exploitation
vulnerable applications.These could be either remote or local vectors.
