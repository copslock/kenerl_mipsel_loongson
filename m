Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 21:43:46 +0100 (CET)
Received: from mail-lb0-f175.google.com ([209.85.217.175]:60801 "EHLO
        mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6870569AbaA0UnoJfeEZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Jan 2014 21:43:44 +0100
Received: by mail-lb0-f175.google.com with SMTP id p9so4890193lbv.34
        for <linux-mips@linux-mips.org>; Mon, 27 Jan 2014 12:43:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=4hcRJqirDAnKsznVqvNuphdwtRuuW3wclxbuGaMYxLE=;
        b=P6Qx2i485Ta234NIal1TgzZ650vyIJhekb1TeidlKiqDVmanJPPh4HNizLitFdntMn
         WkUqWwGM3/0NrPK2ncJqExa8R3FYwLIKZbsi5HBc0M0g+N49Ixkmt52ZbjeEFU5IbTtw
         ev4TPPh5VFgrJbKHKLQg3mT8vJ27ugaEKnrfL4OLsGjqzJN8HgbNo2q6jatLu0c5e5mZ
         KKQnRFylltARMI4z7sO4uExQn+QCHrATXNccwOkwjIKv9howZDRN6tjS3nalmEn8C7fq
         YoPkMotjcsbrsCzhO3EdBQgmlarPa9DufxirukcUCrFsXeLIGI6J/QgNC8oL1kDK+j8O
         h5VA==
X-Gm-Message-State: ALoCoQmAdQ5SMq/r82Hd2gXbkeVmUT8JFbSjDvQXslvoJGmmjzol6fEhkizuKrS0Vh8kWwQwNryy
X-Received: by 10.112.141.225 with SMTP id rr1mr92297lbb.59.1390855417780;
        Mon, 27 Jan 2014 12:43:37 -0800 (PST)
Received: from wasted.cogentembedded.com (ppp83-237-62-70.pppoe.mtu-net.ru. [83.237.62.70])
        by mx.google.com with ESMTPSA id gi5sm13538917lbc.4.2014.01.27.12.43.36
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 27 Jan 2014 12:43:37 -0800 (PST)
Message-ID: <52E6D30B.1010101@cogentembedded.com>
Date:   Tue, 28 Jan 2014 00:43:39 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 20/58] MIPS: lib: memset: Whitespace fixes
References: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com> <1390853985-14246-21-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1390853985-14246-21-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39178
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 01/27/2014 11:19 PM, Markos Chandras wrote:

> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>

    You're spoiling intentionally marked delay slots, not fixing anything 
here. This is a convention.

WBR, Sergei
