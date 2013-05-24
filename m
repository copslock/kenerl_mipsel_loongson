Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 May 2013 19:30:27 +0200 (CEST)
Received: from mail-pd0-f180.google.com ([209.85.192.180]:38812 "EHLO
        mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823031Ab3EXRaWdzzGx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 May 2013 19:30:22 +0200
Received: by mail-pd0-f180.google.com with SMTP id 14so1970141pdc.39
        for <multiple recipients>; Fri, 24 May 2013 10:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=iQN31MTLa7fJGXI+Txj/m9afd8zh6ISmDulWuCwQwyQ=;
        b=Bk85gYQP9BcIBEH1xYlHh8fb0lDSjXbQhu7MczDTcT3/6m/8Y0toDsydkuplJDPCVE
         D5V9Qp4Z6dVhVpjZHUuMge5/158IeWhnGTizl4Ew74BB70gkadrJhiQlBYIqmaOjjd66
         N4ivb/8turyGi456QTCtTYr5j+rFAoaVEZf8uO4VWlrOS063UKc0Xspgsos9kMuirknv
         vVlT20dmaplLXP+NWZ6t77OmblKyABNHHb0chyDFBVlSbGoGp6/ZAHJ3tHqtDuIjemH5
         rph+dlMnDCSfiIWVlp2VCZLUw1dMMe870Z94Q3F6Bd0WbM8/Id3WkOst+cAAG3bLZ0bR
         toPg==
X-Received: by 10.66.21.38 with SMTP id s6mr19095633pae.103.1369416615841;
        Fri, 24 May 2013 10:30:15 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id ri8sm16989324pbc.3.2013.05.24.10.30.14
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 10:30:14 -0700 (PDT)
Message-ID: <519FA3A5.7070408@gmail.com>
Date:   Fri, 24 May 2013 10:30:13 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     Tony Wu <tung7970@gmail.com>
CC:     ralf@linux-mips.org, Steven.Hill@imgtec.com,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: microMIPS: Refactor mips16 get_frame_info support
References: <20130524145535.GA5369@hades>
In-Reply-To: <20130524145535.GA5369@hades>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36589
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

On 05/24/2013 07:55 AM, Tony Wu wrote:
[...]
>
> Signed-off-by: Tony Wu <tung7970@gmail.com>
> Cc: Steven J. Hill <Steven.Hill@imgtec.com>
> ---
>   arch/mips/kernel/process.c |  214 +++++++++++++++++++++++++++++---------------
>   1 file changed, 141 insertions(+), 73 deletions(-)
>
> diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
> index c6a041d..c335a7f 100644
> --- a/arch/mips/kernel/process.c
> +++ b/arch/mips/kernel/process.c
> @@ -211,14 +211,17 @@ struct mips_frame_info {
>   	int		pc_offset;
>   };
>
> +#ifdef CONFIG_CPU_MICROMIPS
> +#define J_TARGET(pc,target)	\
> +		(((unsigned long)(pc) & 0xf8000000) | ((target) << 1))
> +#else
>   #define J_TARGET(pc,target)	\
>   		(((unsigned long)(pc) & 0xf0000000) | ((target) << 2))
> +#endif

I really dislike this #ifdefery.


>
>   static inline int is_ra_save_ins(union mips_instruction *ip)
>   {
>   #ifdef CONFIG_CPU_MICROMIPS

And here too.

Would it be better to leave the existing objects alone, and add 
microMIPS functions and macros with new names?



[...]
> + * 2. access the fetched word using halfword (defeat endian issue)
> + * 3. assemble 16/32 bit MIPS16 instruction from halfword(s)
> + */
> +static inline void MIPS16_fetch_halfword(union mips_instruction **ip,

No inline for any of these functions.

> +					 unsigned short *this_halfword,
> +					 unsigned short *prev_halfword)
> +{
> +	if (*prev_halfword) {
[...]
David Daney
