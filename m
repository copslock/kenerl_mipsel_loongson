Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jul 2016 09:58:18 +0200 (CEST)
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35177 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993299AbcGNH6MO7wrQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Jul 2016 09:58:12 +0200
Received: by mail-wm0-f68.google.com with SMTP id i5so8534695wmg.2;
        Thu, 14 Jul 2016 00:58:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=syDXq51lM5J/xKJAa2dwdTahV56/vLNHakwl46jGe78=;
        b=cOJDHMIWJJzRwTzKw3z8auF6M2lQBsOad2oPPMkjqgzVmQZAERNGDYYcPNrdG/eQX6
         PptzbzqQuBuwyVNKPRWG9JaDeWDWNzV48Q8hL6iiUwBx33rO2rHW/6yG2ik9SiqHK5Qj
         tEP4ILLoy6epUR8pKA6bY4nSKmqpWNDhjFZSs8XLh32xQfgXuiPlK0hC/nZwkGu9LiNM
         nf2q6JJ3hEuXxm2p5dn4rxUSHLYza5srQO/tfVcvO/mxmSgMXVPqH/qTpIpP1z0MueRa
         GZyKFS6/MGziwBCTcAM05tDU45ZkD6QKVzlKd5+ZB0OwOH7JShv01N+aTeb8nrcQA1NG
         aRJw==
X-Gm-Message-State: ALyK8tLN5iyZESlfMmnLwHjWcShTOyjJ8mjQFTFWAil26BZf0xcZNTdKNg7pPOVhI22aUA==
X-Received: by 10.194.239.232 with SMTP id vv8mr5426030wjc.150.1468483087002;
        Thu, 14 Jul 2016 00:58:07 -0700 (PDT)
Received: from ?IPv6:2a01:4240:2e27:ad85:aaaa::19f? (f.9.1.0.0.0.0.0.0.0.0.0.a.a.a.a.5.8.d.a.7.2.e.2.0.4.2.4.1.0.a.2.v6.cust.nbox.cz. [2a01:4240:2e27:ad85:aaaa::19f])
        by smtp.gmail.com with ESMTPSA id x62sm4497360wmf.13.2016.07.14.00.58.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jul 2016 00:58:06 -0700 (PDT)
Subject: Re: [BACKPORT 3.14.y] MIPS: KVM: Fix modular KVM under QEMU
To:     James Hogan <james.hogan@imgtec.com>, stable@vger.kernel.org
References: <146827994122156@kroah.com>
 <1468430059-7958-1-git-send-email-james.hogan@imgtec.com>
Cc:     gregkh@linuxfoundation.org, rkrcmar@redhat.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org
From:   Jiri Slaby <jslaby@suse.cz>
Message-ID: <f2262a47-8365-3386-4d8b-a2d4a1b1ea7f@suse.cz>
Date:   Thu, 14 Jul 2016 09:58:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <1468430059-7958-1-git-send-email-james.hogan@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <jirislaby@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54329
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

On 07/13/2016, 07:14 PM, James Hogan wrote:
> commit 797179bc4fe06c89e47a9f36f886f68640b423f8 upstream.

Applied to 3.12 too. Thanks!

-- 
js
suse labs
