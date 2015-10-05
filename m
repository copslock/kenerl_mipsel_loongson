Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Oct 2015 16:08:39 +0200 (CEST)
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35130 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009515AbbJEOIhsCRHQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Oct 2015 16:08:37 +0200
Received: by pacfv12 with SMTP id fv12so181862839pac.2
        for <linux-mips@linux-mips.org>; Mon, 05 Oct 2015 07:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=pMZLD6AUwAQDL8o0ZO+96vfSVIW25xH41euIg4AQ6Lg=;
        b=YEJhOMy4r2Mj2JUrLSjaZgVAHhfh3vzEcxOIFMDe7k1skiUQzPYoLHhQ3Yll6VGWk/
         d5wJAmMQOlX5MlLXWnb2Xa0TKovYhJB0d7ISd/MGACZ2XukD4Qw5MZ3s59E83sfUJV6O
         +2tJ5E9beZrARM50iz5Ux1eOjce4PzB0WC17Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=pMZLD6AUwAQDL8o0ZO+96vfSVIW25xH41euIg4AQ6Lg=;
        b=eFKadNueVerBZZHfOcVVt3eZt1VZQwYXoDD8t3w5MiuET88Dgm0uBRNjBvuYBqRnKH
         H6eVHuztuVU+C0pCFKonnSQEFl33Jl5XWkcnDkwDOblu1LFC7InT1NeUAzcIwGEomeAw
         R9ECOoCFIZeSobiYyJKUxn8Xyrw8dB2Ebn7wUiw4DlzmtZdIQlSnmuteTzBUbk8Gl3bf
         zDDvKA9HYuS2MbxrGjGu25fB/okE5uC1uAV8TdfhxK9YsvTypNfSXc+ftXcpR0APa1Lf
         0veACBoNTxF5GLbBc8VRS1YQR5b1QWcpyrhdbG57RNWHcsMCzB+VUNMApikF4UMUPttg
         BSgw==
X-Gm-Message-State: ALoCoQlLIoH0qTkaBDhhmQPcTkOc8stzWHTMtqlNdlgQxmLM01GIPjBZR0UrmGmMey5xwlnJxYwf
X-Received: by 10.66.102.106 with SMTP id fn10mr40743881pab.156.1444054108389;
        Mon, 05 Oct 2015 07:08:28 -0700 (PDT)
Received: from [192.168.1.102] ([174.51.92.64])
        by smtp.googlemail.com with ESMTPSA id st5sm26036359pab.42.2015.10.05.07.08.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 Oct 2015 07:08:27 -0700 (PDT)
Subject: Re: [PATCH net-next 3/5] net: Refactor path selection in
 __ip_route_output_key
To:     David Miller <davem@davemloft.net>, lkp@intel.com
References: <1443713247-11230-4-git-send-email-dsa@cumulusnetworks.com>
 <201510021431.hGNWKbMp%fengguang.wu@intel.com>
 <20151005.063836.1612675139838377064.davem@davemloft.net>
Cc:     kbuild-all@01.org, netdev@vger.kernel.org, dsahern@gmail.com,
        linux-mips@linux-mips.org
From:   David Ahern <dsa@cumulusnetworks.com>
Message-ID: <5612845A.9090203@cumulusnetworks.com>
Date:   Mon, 5 Oct 2015 08:08:26 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:38.0)
 Gecko/20100101 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <20151005.063836.1612675139838377064.davem@davemloft.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <dsa@cumulusnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49442
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dsa@cumulusnetworks.com
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

On 10/5/15 7:38 AM, David Miller wrote:
> From: kbuild test robot <lkp@intel.com>
> Date: Fri, 2 Oct 2015 14:20:30 +0800
>
>> Hi David,
>>
>> [auto build test results on next-20151001 -- if it's inappropriate base, please ignore]
>>
>> config: mips-nlm_xlp_defconfig (attached as .config)
>> reproduce:
>>          wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # save the attached .config to linux build tree
>>          make.cross ARCH=mips
>>
>> All warnings (new ones prefixed by >>):
>>
>>>> mips-linux-gnu-ld: net/ipv4/.tmp_fib_semantics.o: warning: Inconsistent ISA between e_flags and .MIPS.abiflags
>
> Frankly this looks like a build infrastructure or tools bug to me.
>

That's pretty much what I got back from Joshua on the linux-mips mailing 
list when I inquired about why a code move generates the warning:

"Dunno if your patch generated the message per-say, but it seems some 
platforms in the MIPS tree cause this message to appear. I.e., IP27 or 
IP32 builds (or IP30 out-of-tree) don't emit this error, but building 
IP28 systems in-tree will cause it to appear quite a bit.

The message itself, I believe is complaining that the stated CPU ISA 
(mips1 ... mips4, mips32r2, r10000, etc) in one of the sections 
(e.g.,.MIPS.abiflags) doesn't match the equivalent ISA value in the 
other section (e.g., e_flags). I haven't seen any harmful side effects 
of it myself. Seems to be more of a warning than anything else, and as 
long as the ISA matches a supported CPU (e.g., r10000 is compatible with 
mips4), it can be ignored. It does clutter up the build, though."
