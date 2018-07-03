Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jul 2018 10:00:25 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45148 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992916AbeGCIAPYsUoZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Jul 2018 10:00:15 +0200
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w637xr3a104849
        for <linux-mips@linux-mips.org>; Tue, 3 Jul 2018 04:00:13 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k0473ak74-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Tue, 03 Jul 2018 04:00:13 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <ravi.bangoria@linux.ibm.com>;
        Tue, 3 Jul 2018 09:00:11 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Jul 2018 09:00:06 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w63805WD31522942
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Jul 2018 08:00:05 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 95E51AE05A;
        Tue,  3 Jul 2018 11:00:08 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4BCE5AE055;
        Tue,  3 Jul 2018 11:00:05 +0100 (BST)
Received: from [9.124.31.159] (unknown [9.124.31.159])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Jul 2018 11:00:05 +0100 (BST)
Subject: Re: [PATCH v5 10/10] perf probe: Support SDT markers having reference
 counter (semaphore)
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>, mhiramat@kernel.org
Cc:     oleg@redhat.com, rostedt@goodmis.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, ananth@linux.vnet.ibm.com,
        alexis.berlemont@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
 <20180628052209.13056-11-ravi.bangoria@linux.ibm.com>
 <20180702145727.GC65296@linux.vnet.ibm.com>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Tue, 3 Jul 2018 13:30:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180702145727.GC65296@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18070308-0020-0000-0000-000002A283D2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070308-0021-0000-0000-000020EE999F
Message-Id: <c29309ae-65ff-8a68-42ef-7e9f77227571@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-03_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807030092
Return-Path: <ravi.bangoria@linux.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64562
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ravi.bangoria@linux.ibm.com
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

Hi Srikar,

On 07/02/2018 08:27 PM, Srikar Dronamraju wrote:
> * Ravi Bangoria <ravi.bangoria@linux.ibm.com> [2018-06-28 10:52:09]:
> 
>> With this, perf buildid-cache will save SDT markers with reference
>> counter in probe cache. Perf probe will be able to probe markers
>> having reference counter. Ex,
>>
>>   # readelf -n /tmp/tick | grep -A1 loop2
>>     Name: loop2
>>     ... Semaphore: 0x0000000010020036
>>
>>   # ./perf buildid-cache --add /tmp/tick
> 
> Would this perf buildid-cache work if the executable is stripped of
> symbols?

Description of SDT markers resides in .notes section. If .notes section
is there, binary has SDT markers, if .notes section is not there, binary
does not have any SDT markers. So SDT markers does not have anything to
do with symbol table.

> 
>>   # ./perf probe sdt_tick:loop2
>>   # ./perf stat -e sdt_tick:loop2 /tmp/tick
>>     hi: 0
>>     hi: 1
>>     hi: 2
>>     ^C
>>      Performance counter stats for '/tmp/tick':
>>                  3      sdt_tick:loop2
>>        2.561851452 seconds time elapsed
> 
> Also can we document how to use SDT markers with perf under perf-probe
> or perf-build-cache?
> 

Yes, perf-buildid-cache and perf-probe man pages describes about SDT
markers.

Thanks,
Ravi
