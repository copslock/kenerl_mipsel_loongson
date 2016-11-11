Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Nov 2016 09:43:07 +0100 (CET)
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33159 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991859AbcKKInBNs8Fo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Nov 2016 09:43:01 +0100
Received: by mail-wm0-f68.google.com with SMTP id u144so7856626wmu.0;
        Fri, 11 Nov 2016 00:43:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=f3LbcbTIlj/2GSO66/mMkFNL2CVvWPvDl5rhkdxaYQs=;
        b=SFw4mMKWR9QkjVhNNMqwS9/IjggEcE8oxMh+7bKQIhwXHDfOiKTcNKnvCQm1pMEUx2
         6d1SuunfNYj5iqJx8DrrqzGYLfLRvLDJEao7u73NamWeAQ/0iPRxleVuHb7ZsnD5kxNK
         +z6mG6XWOsAEQMbatE73Khd1phF/MVnbzZ6SQXmWd/M4bqVhLxfcIgwNozYhugmwxQG1
         WeHjO7Jhmzhjq7KCrFnkuthtQI0+sBe2W8BK0jE4Kt4TuBPXX4+pa7PIycdEd5lFDZDB
         m3wwNYfPC80IfVaMFJ+6ipShduop7qIA1s4PWH9/fw+ZdBtG/F/tei5QVzn7Efzpf9oH
         0NiQ==
X-Gm-Message-State: ABUngvegG21uPkil9jCXJ4xwU0qRoNwVpAsTqkU58VMIHCU9+b0cu9zhdmyNXYCxw4r/hg==
X-Received: by 10.194.108.10 with SMTP id hg10mr9754763wjb.58.1478853775868;
        Fri, 11 Nov 2016 00:42:55 -0800 (PST)
Received: from ?IPv6:2a01:4240:2e27:ad85:aaaa::19f? (f.9.1.0.0.0.0.0.0.0.0.0.a.a.a.a.5.8.d.a.7.2.e.2.0.4.2.4.1.0.a.2.v6.cust.nbox.cz. [2a01:4240:2e27:ad85:aaaa::19f])
        by smtp.gmail.com with ESMTPSA id 1sm10831856wmk.22.2016.11.11.00.42.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Nov 2016 00:42:54 -0800 (PST)
Subject: Re: [BACKPORT PATCH 3.10..3.16] KVM: MIPS: Drop other CPU ASIDs on
 guest MMU changes
To:     Fengguang Wu <fengguang.wu@intel.com>,
        James Hogan <james.hogan@imgtec.com>
References: <20161109144624.16683-1-james.hogan@imgtec.com>
 <6066667d-e62d-bfec-ca3e-f16f8bef912d@suse.cz>
 <20161109220043.GA7075@jhogan-linux.le.imgtec.org>
 <20161110060843.GA28639@kroah.com>
 <20161110173721.GD7075@jhogan-linux.le.imgtec.org>
 <20161111025621.vwa3irwbj56uezhl@wfg-t540p.sh.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org, Paul Burton <Paul.Burton@imgtec.com>
From:   Jiri Slaby <jslaby@suse.cz>
Message-ID: <f15a92c6-390d-cb7a-afb1-0d47d6f44af2@suse.cz>
Date:   Fri, 11 Nov 2016 09:42:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161111025621.vwa3irwbj56uezhl@wfg-t540p.sh.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <jirislaby@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55782
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

On 11/11/2016, 03:56 AM, Fengguang Wu wrote:
>> Can we please get a few MIPS defconfigs added to the 0-day testing?
> 
> The 0-day build bot should already cover the below configs (not
> necessarily in the early hours, but very likely in the first day after
> your git push) since they are included in arch/*/configs/. I wonder
> where you test your patches?  Let me check how they missed the test
> coverage.

Hello, it is mostly about my stable-3.12 at:
git://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux-stable

The status mail stated:
The following configs have been built successfully.
More configs may be tested in the coming days.
...
mips                                   jz4740
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9

thanks,
-- 
js
suse labs
