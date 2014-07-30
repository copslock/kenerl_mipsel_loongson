Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jul 2014 19:06:12 +0200 (CEST)
Received: from mail-ig0-f179.google.com ([209.85.213.179]:34242 "EHLO
        mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6855028AbaG3RGJrRn0r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Jul 2014 19:06:09 +0200
Received: by mail-ig0-f179.google.com with SMTP id h18so3302626igc.0
        for <multiple recipients>; Wed, 30 Jul 2014 10:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=rNJwcwU+lfnfZkOLyrDY5gXmenxUiYJ7RiRhORHSgWk=;
        b=npeXVGZvpgFhLjXSTNf+BwvekIfrWVkBHPUwzH01YIlQkZNoFJkljK+UxiU9MAe7TO
         j/MepdnE+SSszJmOGZa/KiVOmOZcfeHn3lhF0NJYiW+H+4/d4rSQVxhTUat36rHOxXWn
         WTqAJyv/EAXMbENxgnI75Pqnql65LkZWBrlHwdmQ3x5w714v21tc2mYyLp/rip2eX9JK
         bAkIG2feZkOmb1MhNTDtF4Kl0hI4TWBcvTNnZ/lPSgqj/fkcRabBr29YGg8rbYVGs9CC
         ty8jJubNZmYszFU6U0lVoiaTwL9RzPv4Pu84Is38daG43raVpFPPdT/FIEVBjRhVAYcn
         ah6Q==
X-Received: by 10.43.154.145 with SMTP id le17mr6709271icc.20.1406739963537;
        Wed, 30 Jul 2014 10:06:03 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id ga11sm11472018igd.8.2014.07.30.10.06.01
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 30 Jul 2014 10:06:02 -0700 (PDT)
Message-ID: <53D925F9.5090001@gmail.com>
Date:   Wed, 30 Jul 2014 10:06:01 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Ralf <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        "Markos (GMail)" <markos.chandras@gmail.com>,
        Markos <markos.chandras@imgtec.com>,
        Paul <paul.burton@imgtec.com>,
        Rob Kendrick <rob.kendrick@codethink.co.uk>,
        Alex Smith <alex@alex-smith.me.uk>,
        Huacai Chen <chenhc@lemote.com>
Subject: Re: Please add my temporary MIPS fixes branch to linux-next
References: <53D9169D.3020705@imgtec.com>
In-Reply-To: <53D9169D.3020705@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41814
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 07/30/2014 09:00 AM, James Hogan wrote:
[...]

> ... Since Ralf appears to be unavailable at the moment ...
>
[...]

This doesn't seem to be a temporary situation.

If we want to keep the MIPS architecture in a functioning state, it may 
make sense to establish an alternate path for merging MIPS patches upstream.

David Daney.
